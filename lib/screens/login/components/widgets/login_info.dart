import 'package:dekor_farben_app/screens/login/components/store/login_store.dart';
import 'package:dekor_farben_app/screens/login/components/widgets/open_login_modal_button_widget.dart';
import 'package:flutter/material.dart';

class LoginInfoWidget extends StatelessWidget {
  final Size size;
  final LoginStore loginStore;

  const LoginInfoWidget({
    super.key,
    required this.size,
    required this.loginStore,
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
              OpenLoginModalButtonWidget(size: size, buttonText: "Usuário", loginStore: loginStore),
              SizedBox(width: size.width * .1),
              OpenLoginModalButtonWidget(size: size, buttonText: "Empresa", loginStore: loginStore)
            ],
          )
        ],
      ),
    );
  }
}