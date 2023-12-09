import 'package:dekor_farben_app/screens/invoice_screen/components/view/invoice_screen_body.dart';
import 'package:dekor_farben_app/screens/invoice_screen/invoice_screen.dart';
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
            destinationWidget: InvoiceScreen(),
            widgetIcon: Icons.attach_file,
            widgetText: 'Notas Fiscais')
      ],
    );
  }
}
