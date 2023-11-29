import 'package:flutter/material.dart';

import '../../../../choose_company_screen/choose_company_screen.dart';
import 'menu_icon_widget.dart';

class CompanyCustomDrawerWidget extends StatelessWidget {
  const CompanyCustomDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        MenuIconWidget(
            destinationWidget: ChooseCompanyScreen(),
            widgetIcon: Icons.attach_money,
            widgetText: 'Campanhas')
      ],
    );
  }
}
