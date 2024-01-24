import 'dart:ffi';

import 'package:dekor_farben_app/blocs/campaign/campaign_bloc.dart';
import 'package:dekor_farben_app/core/entities/campaign.dart';
import 'package:dekor_farben_app/screens/campaign_edit_screen/components/view/campaign_edit_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CampaignEditScreen extends StatelessWidget {
  final Campaign campaign;

  const CampaignEditScreen({super.key, required this.campaign});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CampaignBloc>(
      create: (context) => CampaignBloc(),
      child: Scaffold(
        body: CampaignEditBody(campaign: campaign),
      ),
    );
  }
}
