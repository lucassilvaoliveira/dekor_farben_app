import 'package:dekor_farben_app/blocs/auth/auth_bloc.dart';
import 'package:dekor_farben_app/blocs/auth/auth_event.dart';
import 'package:dekor_farben_app/blocs/auth/auth_state.dart';
import 'package:dekor_farben_app/global/constants.dart';
import 'package:dekor_farben_app/global/widgets/dialogs/on_error_dialog.dart';
import 'package:dekor_farben_app/infrastructure/auth/auth_request.dart';
import 'package:dekor_farben_app/screens/choose_company_screen/choose_company_screen.dart';
import 'package:dekor_farben_app/screens/choose_company_screen/components/reducer/global_company_store.dart';
import 'package:dekor_farben_app/screens/home_screen/home_screeen.dart';
import 'package:dekor_farben_app/screens/onboarding_screen/components/widgets/text_field_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../global/widgets/primary_button_widget.dart';

class LoginFormWidget extends StatefulWidget {
  final PageController pageController;
  final double bottomSheetHeight;

  const LoginFormWidget({super.key,
    required this.pageController,
    required this.bottomSheetHeight});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  final globalCompanyStore = GlobalCompanyStore.store;

  _authenticate() {
    final request = AuthRequest(
        email: _loginController.text,
        password: _passwordController.text
    );
    BlocProvider.of<AuthBloc>(context).add(OnAuthEvent(aRequest: request));
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          final companyStore = GlobalCompanyStore.store;

          Navigator.push(
            context,
            userType == 'user' ? CupertinoPageRoute(
              builder: (context) => const ChooseCompanyScreen(),
            ) : CupertinoPageRoute(
                builder: (context) =>
                    HomeScreen(company: companyStore.state.company)
            ),
          );
        } else if (state is AuthFailureState) {
          onErrorDialog(
              aContext: context,
              aTitle: "Credenciais Incorretas!",
              aSubtitle: "Email ou senha incorretos, tente novamente!",
              onOkPressed: () => Navigator.pop(context)
          );
        }
      },
      builder: (context, state) {
        if (state is AuthLoadingState) {
          return const Center(
              child: SpinKitCircle(
                color: kDefaultPrimaryColor,
                size: 100,
              )
          );
        } else {
          return _loadForm(size);
        }
      },
    );
  }

  Widget _loadForm(final Size size) {
    return Container(
      margin: const EdgeInsets.all(15),
      child: Padding(
        padding:
        EdgeInsets.only(bottom: MediaQuery
            .of(context)
            .viewInsets
            .bottom),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Realize seu Login',
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleLarge),
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
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontSize: 20)),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: size.width * 0.4,
                    child: PrimaryButtonWidget(
                        text: 'Entrar',
                        onPressed: () async => _authenticate()),
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
