import 'dart:convert';

import 'package:dekor_farben_app/core/entities/company.dart';
import 'package:dekor_farben_app/core/entities/user.dart';
import 'package:dekor_farben_app/global/constants.dart';
import 'package:dekor_farben_app/global/secure_storage.dart';
import 'package:dekor_farben_app/global/widgets/dialogs/on_error_dialog.dart';
import 'package:dekor_farben_app/screens/choose_company_screen/choose_company_screen.dart';
import 'package:dekor_farben_app/screens/choose_company_screen/components/reducer/company_action.dart';
import 'package:dekor_farben_app/screens/choose_company_screen/components/reducer/global_company_store.dart';
import 'package:dekor_farben_app/screens/home_screen/home_screeen.dart';
import 'package:dekor_farben_app/screens/onboarding_screen/components/reducer/global_user_store.dart';
import 'package:dekor_farben_app/screens/onboarding_screen/components/reducer/user_action.dart';
import 'package:dekor_farben_app/screens/onboarding_screen/components/widgets/text_field_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../global/routes/routes.dart';
import '../../global/widgets/primary_button_widget.dart';

class LoginFormWidget extends StatefulWidget {
  final PageController pageController;
  final double bottomSheetHeight;

  const LoginFormWidget(
      {super.key,
      required this.pageController,
      required this.bottomSheetHeight});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  final globalCompanyStore = GlobalCompanyStore.store;

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

    if (userType == 'company') {
      await _storeCurrentCompany(_loginController.text, token);
    }
  }

  Future<void> _storeCurrentCompany(final String email, final String token) async {
    final getCompanyUri = Uri.parse(Routes.companies);

    final queryParams = {"sort": "email", "search": _loginController.text};

    final getCompanyUriWithParams =
    getCompanyUri.replace(queryParameters: queryParams);

    final request = await http.get(getCompanyUriWithParams, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization':
      'Bearer $token',
    });

    final Map<String, dynamic> response = jsonDecode(request.body);
    final Company company = Company.fromApi(response["items"][0]);
    globalCompanyStore.dispatch(SetCompanyAction(company: company));
  }

  void authenticate() async {
    if (await isAuthenticated()) {
      if (!mounted) return;

      final companyStore = GlobalCompanyStore.store;

      Navigator.push(
        context,
        userType == 'user' ? CupertinoPageRoute(
          builder: (context) => const ChooseCompanyScreen(),
        ) : CupertinoPageRoute(
          builder: (context) => HomeScreen(company: companyStore.state.company)
        ),
      );
    } else {
      if (!mounted) return;

      onErrorDialog(
          aContext: context,
          aTitle: "Credenciais Incorretas!",
          aSubtitle: "Email ou senha incorretos, tente novamente!",
          onOkPressed: () => Navigator.pop(context)
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
