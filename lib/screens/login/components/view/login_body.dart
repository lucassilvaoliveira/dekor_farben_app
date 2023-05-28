import 'package:dekor_farben_app/screens/login/components/store/login_store.dart';
import 'package:dekor_farben_app/screens/login/components/widgets/login_info.dart';
import 'package:dekor_farben_app/screens/login/components/widgets/stack_image_widget.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  final LoginStore loginStore;
  const LoginView({super.key, required this.loginStore});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              StackImageWidget(size: size),
              LoginInfoWidget(size: size, loginStore: loginStore)
            ],
          ),
        ),
      ),
    );
  }
}
