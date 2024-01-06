import 'dart:convert';

import 'package:dekor_farben_app/core/entities/user.dart';
import 'package:dekor_farben_app/global/secure_storage.dart';
import 'package:dekor_farben_app/screens/choose_company_screen/choose_company_screen.dart';
import 'package:dekor_farben_app/screens/onboarding_screen/components/reducer/global_user_store.dart';
import 'package:dekor_farben_app/screens/onboarding_screen/components/reducer/user_action.dart';
import 'package:dekor_farben_app/screens/onboarding_screen/components/widgets/text_field_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../global/routes/routes.dart';
import '../../global/widgets/primary_button_widget.dart';

class LoginFormWidget extends StatefulWidget {
  final PageController pageController;
  final double bottomSheetHeigh;

  const LoginFormWidget(
      {super.key,
      required this.pageController,
      required this.bottomSheetHeigh});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<bool> isAuthenticated() async {
    final response = await http.post(
      Uri.parse(Routes.authenticate),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
      body: jsonEncode(<String, String>{
        "email": _loginController.text,
        "password": _passwordController.text
      }),
    );

    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      final currentTime = DateTime.now().millisecondsSinceEpoch;
      final expirationTime =
          currentTime + const Duration(days: 5).inMilliseconds;

      final token = jsonDecode(response.body)["token"];

      SecureStorage()
          .writeSourceData("jwt", token);

      prefs.setInt("jwtExpiration", expirationTime);

      await _storeCurrentUser(token);

      return true;
    }

    return false;
  }

  Future<void> _storeCurrentUser(final String token) async {
    final getUserUri = Uri.parse(Routes.users);

    final queryParams = {"sort": "email", "search": _loginController.text};

    final getUserUriWithParams =
        getUserUri.replace(queryParameters: queryParams);

    final userResponse = await http.get(getUserUriWithParams, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization':
      'Bearer $token',
    });

    final Map<String, dynamic> userResponseApi = jsonDecode(userResponse.body);
    final List<dynamic> userJson = userResponseApi['items'];
    final User user = User.fromRestRoute(userJson[0]);
    final globalUserStore = GlobalUserStore.store;
    globalUserStore.dispatch(SetUserAction(user: user));
  }

  void authenticate() async {
    if (await isAuthenticated()) {
      if (!mounted) return;

      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => const ChooseCompanyScreen(),
        ),
      );
    } else {
      if (!mounted) return;

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              margin: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                  color: const Color(0xff2A303E),
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    "assets/images/alert_icon.svg",
                    width: 72,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    'Credenciais Incorretas!',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 25, color: const Color(0xffEC5B5B)),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    'Email ou senha incorretos, tente novamente!',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.white, fontSize: 17),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff5BEC84),
                            foregroundColor: const Color(0xff2A303E),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 32),
                          ),
                          child: const Text('OK'))
                    ],
                  )
                ],
              ),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;

    return Container(
      margin: const EdgeInsets.all(15),
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Realize seu Login',
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 25),
              TextFieldWidget(
                  controller: _loginController,
                  label: 'Email',
                  icon: Icons.email),
              TextFieldWidget(
                controller: _passwordController,
                label: 'Senha',
                icon: Icons.lock,
                hidden: true,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (widget.pageController.page == 0) {
                        widget.pageController.animateToPage(1,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.ease);
                      }
                    },
                    child: Text('Criar Conta',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontSize: 20)),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: size.width * 0.4,
                    child: PrimaryButtonWidget(
                        text: 'Entrar', onPressed: () async => authenticate()),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
