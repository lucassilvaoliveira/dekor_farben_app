import 'package:dekor_farben_app/core/entities/campaign.dart';
import 'package:dekor_farben_app/global/constants.dart';
import 'package:dekor_farben_app/screens/campaign_details_screen/campaign_details_screen.dart';
import 'package:dekor_farben_app/screens/campaign_edit_screen/campaign_edit_screen.dart';
import 'package:dekor_farben_app/screens/home_screen/components/widgets/coins_amount_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../global/date_utils.dart';

class CampaignWidget extends StatelessWidget {
  final Size size;
  final Campaign campaign;
  const CampaignWidget({
    super.key,
    required this.size,
    required this.campaign,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => userType == 'user' ?
            CampaignDetailsScreen(
              campaign: campaign,
            ) : CampaignEditScreen(campaign: campaign),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              campaign.campaignName,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            CoinsAmountWidget(amount: campaign.campaignReward),
            const SizedBox(height: 10),
            Text(
              campaign.campaignDescription,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontSize: 18),
            ),
            Container(
              margin: EdgeInsets.only(top: size.height * .07),
              child: Text(
                "Criada em: ${dateTimeToString(campaign.campaignInitialDate)}",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontSize: 18),
              ),
            ),
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: 'Acaba em: ',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontSize: 18)),
              TextSpan(
                  text: dateTimeToString(campaign.campaignEndDate),
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontSize: 18, fontWeight: FontWeight.bold))
            ])),
          ],
        ),
      ),
    );
  }
}
