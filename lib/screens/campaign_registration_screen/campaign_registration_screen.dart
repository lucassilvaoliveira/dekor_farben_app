import 'package:flutter/material.dart';

import 'components/view/campaign_registration_body.dart';

class CampaignRegistrationScreen extends StatelessWidget {
  const CampaignRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CampaignRegistrationBody(),
    );
  }
}