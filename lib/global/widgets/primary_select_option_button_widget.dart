import 'package:flutter/material.dart';

class PrimarySelectOptionButtonWidget extends StatelessWidget {
  final Color widgetColor;
  final String text;
  final bool isOpacity;

  const PrimarySelectOptionButtonWidget({
    Key? key,
    required this.text,
    required this.isOpacity,
    required this.widgetColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * .05,
      width: size.width * .40,
      decoration: BoxDecoration( 
        color: widgetColor.withOpacity(isOpacity ? .2 : 1),
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30)
        ),
      ),
      child: GestureDetector(
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
