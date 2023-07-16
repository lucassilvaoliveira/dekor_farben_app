import 'package:dekor_farben_app/screens/login_screen/components/widgets/image_clipper.dart';
import 'package:flutter/material.dart';

class StackImageWidget extends StatelessWidget {
  final Size size;

  const StackImageWidget({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(size.width * .02),
      height: size.height * .6,
      width: size.width,
      child: Stack(
        children: [
          Positioned(
            child: Container(
              height: size.height * .6,
              width: size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(size.height * .15),
                  bottomRight: Radius.circular(size.height * .15),
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                ),
              ),
              child: ClipPath(
                clipper: ImageClipper(),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      "assets/images/login-background.png",
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: -50,
            child: Image.asset("assets/images/decorator-login-image.png"),
          )
        ],
      ),
    );
  }
}
