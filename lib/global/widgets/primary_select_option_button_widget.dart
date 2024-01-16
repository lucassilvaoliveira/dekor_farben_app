import 'package:flutter/material.dart';

import '../constants.dart';

class PrimarySelectOptionButtonWidget extends StatelessWidget {
  final Color widgetColor;
  final String text;
  final bool isOpacity;
  final Function onPressed;

  const PrimarySelectOptionButtonWidget({
    Key? key,
    required this.text,
    required this.isOpacity,
    required this.widgetColor,
    required this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * .05,
      width: size.width * .40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: kDefaultPrimaryColor.withOpacity(isOpacity ? .2 : 1),
        ),
        onPressed: isOpacity ? () {} : () => onPressed(),
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15
            ),
          ),
        ),
      ),
    );
  }
}
