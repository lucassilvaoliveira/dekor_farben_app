import 'package:dekor_farben_app/screens/home_screen/home_screeen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CompanyWidget extends StatelessWidget {
  final Size size;
  const CompanyWidget({
    super.key,
    required this.size,
  });


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushAndRemoveUntil(
            context,
            CupertinoPageRoute(builder: (context) => const HomeScreen()),
            (route) => false);
      },
      child: Container(
        color: Colors.transparent,
        padding:
            const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        height: size.height * .14,
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/github-logo.png',
              width: size.width * .25,
            ),
            const SizedBox(height: 10),
            const Text("  Git Hub"),
            const SizedBox(height: 10),
            Container(
              height: 2,
              width: size.width,
              color: Colors.black.withOpacity(.3),
            )
          ],
        ),
      ),
    );
  }
}