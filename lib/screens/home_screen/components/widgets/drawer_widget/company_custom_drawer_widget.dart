import 'package:dekor_farben_app/screens/invoice_screen/invoice_screen.dart';
import 'package:flutter/material.dart';

import 'menu_icon_widget.dart';

class CompanyCustomDrawerWidget extends StatelessWidget {
  const CompanyCustomDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MenuIconWidget(
            destinationWidget: const InvoiceScreen(),
            widgetIcon: Icons.attach_file,
            widgetText: 'Notas Fiscais')
      ],
    );
  }
}
