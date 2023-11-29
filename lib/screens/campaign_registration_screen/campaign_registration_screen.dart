import 'package:dekor_farben_app/screens/campaign_registration_screen/components/view/campaign_registration_body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CampaignRegistrationScreen extends StatelessWidget {
  const CampaignRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CampaignRegistrationBody(),
    );
  }
}
