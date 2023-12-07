import 'package:flutter/material.dart';

import 'components/view/invoice_screen_body.dart';

class InvoiceScreen extends StatelessWidget {
  const InvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: InvoiceScreenBody(),
    );
  }
}
