import 'package:dekor_farben_app/global/constants.dart';
import 'package:flutter/material.dart';

class PrimaryButtonWidget extends StatelessWidget {
  final String text;

  const PrimaryButtonWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * .08,
      width: size.width * .45,
      decoration: BoxDecoration(
        color: kDefaultPrimaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: GestureDetector(
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white, fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }
}
