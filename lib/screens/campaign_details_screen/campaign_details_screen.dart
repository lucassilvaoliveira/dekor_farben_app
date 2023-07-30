import 'package:dekor_farben_app/core/entities/campaign.dart';
import 'package:dekor_farben_app/screens/campaign_details_screen/components/view/campaign_details_body.dart';
import 'package:flutter/material.dart';

class CampaignDetailsScreen extends StatelessWidget {
  final Campaign campaign;
  const CampaignDetailsScreen({super.key, required this.campaign});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CampaignDetailsBody(campaign: campaign),
    );
  }
}
