import 'package:flutter/material.dart';

import 'components/view/settings_body.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SettingsBody(),
    );
  }
}
