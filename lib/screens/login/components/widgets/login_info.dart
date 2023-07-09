import 'package:dekor_farben_app/screens/login/components/widgets/go_to_login_form.dart';
import 'package:flutter/material.dart';

class LoginInfoWidget extends StatelessWidget {
  final Size size;

  const LoginInfoWidget({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * .3,
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Dekor Farben",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: size.height * .05),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GoToLoginForm(size: size, buttonText: "Usuário"),
              SizedBox(width: size.width * .1),
              GoToLoginForm(size: size, buttonText: "Empresa")
            ],
          )
        ],
      ),
    );
  }
}