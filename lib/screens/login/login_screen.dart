import 'package:dekor_farben_app/screens/login/components/presenter/login_presenter.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoginPresenter(),
    );
  }
}