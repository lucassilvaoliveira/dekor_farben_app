import 'package:dekor_farben_app/global/theme_data.dart';
import 'package:dekor_farben_app/global/widgets/rollback_screen_widget.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  final String title;
  final Function()? onBack;

  const AppBarWidget({super.key, required this.title, this.onBack});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RollbackScreenWidget(
          onExec: () => onBack != null ? onBack!() : Navigator.pop(context),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: size.width * .7,
          child: Text(
            title,
            style: kDefaultPrimaryTitle
          ),
        ),
      ],
    );
  }
}
