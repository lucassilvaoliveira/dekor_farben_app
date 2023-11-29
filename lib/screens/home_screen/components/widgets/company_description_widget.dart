import 'package:flutter/material.dart';

import 'coins_amount_widget.dart';

class CompanyDescriptionWidget extends StatelessWidget {
  const CompanyDescriptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: 'Esta é a empresa ',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontSize: 18)),
                TextSpan(
                    text: 'Decor Colors - Blumenau Centro',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(
                        fontSize: 18, fontWeight: FontWeight.bold))
              ])),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          const CoinsAmountWidget(amount: 500),
        ],
      ),
    );
  }
}
