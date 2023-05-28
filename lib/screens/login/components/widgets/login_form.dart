import 'package:dekor_farben_app/screens/login/components/store/login_store.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  final LoginStore loginStore;
  const LoginForm({super.key, required this.loginStore});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Realize seu Login",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 25),
          ),
          const SizedBox(height: 16),
          const TextField(),
          const SizedBox(height: 16),
          const TextField(),
          const SizedBox(height: 32),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Criar Conta", style: Theme.of(context).textTheme?.titleLarge),
              GestureDetector(
                onTap: () {
                  print(loginStore.loginPageController.page);
                },
                child: Container(
                  height: 16,
                  width: 16,
                  color: Colors.purple,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
