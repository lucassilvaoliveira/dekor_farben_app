import 'package:dekor_farben_app/screens/login_screen/components/widgets/login_info.dart';
import 'package:dekor_farben_app/screens/login_screen/components/widgets/stack_image_widget.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

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
              LoginInfoWidget(size: size)
            ],
          ),
        ),
      ),
    );
  }
}
