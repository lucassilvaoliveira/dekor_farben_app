import 'package:flutter/material.dart';

import '../../../../choose_company_screen/choose_company_screen.dart';
import 'menu_icon_widget.dart';

class UserCustomDrawerWidget extends StatelessWidget {
  const UserCustomDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        MenuIconWidget(
            destinationWidget: ChooseCompanyScreen(),
            widgetIcon: Icons.arrow_back,
            widgetText: 'Trocar empresa')
      ],
    );
  }
}
