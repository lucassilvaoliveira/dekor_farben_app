import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/campaign/campaign_bloc.dart';
import 'components/view/campaign_registration_body.dart';

class CampaignRegistrationScreen extends StatelessWidget {
  const CampaignRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CampaignBloc>(
      create: (context) => CampaignBloc(),
      child: const Scaffold(
        body: CampaignRegistrationBody(),
      ),
    );
  }
}