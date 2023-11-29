import 'package:dekor_farben_app/global/constants.dart';
import 'package:flutter/material.dart';

class CoinsAmountWidget extends StatelessWidget {
  final int amount;

  const CoinsAmountWidget({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: amount.toString(),
            style: const TextStyle(
              color: kDefaultPrimaryColor,
              fontSize: 26,
              fontFamily: 'Chivo',
              fontWeight: FontWeight.bold,
            ),
          ),
          const TextSpan(
            text: ' Decor coins',
            style: TextStyle(
              color: kDefaultPrimaryColor,
              fontSize: 20,
              fontFamily: 'Chivo',
              fontWeight: FontWeight.w400,
            ),
          ),
          const WidgetSpan(
            child: Icon(Icons.star, color: kDefaultPrimaryColor),
          )
        ],
      ),
    );
  }
}
