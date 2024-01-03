import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuIconWidget extends StatelessWidget {
  final Widget destinationWidget;
  final IconData widgetIcon;
  final String widgetText;

  final Function()? onPressed;

  const MenuIconWidget(
      { super.key,
        required this.destinationWidget,
        required this.widgetIcon,
        required this.widgetText,
        this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed ?? () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => destinationWidget,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(
              widgetIcon,
              color: Colors.white,
              size: 30,
            ),
            Text(
              widgetText,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
