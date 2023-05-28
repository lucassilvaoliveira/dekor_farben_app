import 'package:dekor_farben_app/screens/login/components/store/login_store.dart';
import 'package:dekor_farben_app/screens/login/components/widgets/create_account_form.dart';
import 'package:dekor_farben_app/screens/login/components/widgets/login_form.dart';
import 'package:flutter/material.dart';

class LoginFormContent extends StatefulWidget {
  final LoginStore loginStore;
  const LoginFormContent({Key? key, required this.loginStore}) : super(key: key);

  @override
  State<LoginFormContent> createState() => _LoginFormContentState();
}

class _LoginFormContentState extends State<LoginFormContent> {
  bool keyboardVisible = false;

  @override
  Widget build(BuildContext context) {
    keyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: keyboardVisible ? 600 : 400,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            children: [
              const SizedBox(height: 16),
              Expanded(
                child: PageView(
                  children: [
                    LoginForm(loginStore: widget.loginStore),
                    CreateAccountForm(),
                  ],
                ),
              )
            ],
          ),
          Positioned(
            height: 56,
            bottom: 32,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              decoration: const BoxDecoration(),
            ),
          )
        ],
      ),
    );
  }
}

