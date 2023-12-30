import 'package:dekor_farben_app/global/constants.dart';
import 'package:flutter/material.dart';

class PrimaryButtonWidget extends StatelessWidget {
  final String text;
  final Function onPressed;

  const PrimaryButtonWidget({
    Key? key,
    required this.text,
    required this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * .08,
      width: size.width * .45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: kDefaultPrimaryColor,
        ),
        onPressed: () => onPressed(),
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
