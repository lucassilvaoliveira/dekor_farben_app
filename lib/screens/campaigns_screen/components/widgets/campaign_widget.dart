import 'package:dekor_farben_app/core/entities/campaign.dart';
import 'package:dekor_farben_app/helpers/date_time_utils.dart';
import 'package:dekor_farben_app/screens/campaign_details_screen/campaign_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
            builder: (context) => CampaignDetailsScreen(
              campaign: campaign,
            ),
          ),
        );
      },
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          height: size.height * .25,
          width: size.width,
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    campaign.campaignName,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.black),
                  ),
                  Text(
                    campaign.campaignIsOpen ? "Aberta" : "Fechada",
                  ),
                ],
              ),
              Text(
                campaign.campaignDescription,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      "Criada em: ${convertDateTimeToShowOnScreen(campaign.createdAt, 'dd/MM/yyyy')}"),
                  Text(
                      "Termina em: ${convertDateTimeToShowOnScreen(campaign.campaignEndDate, 'dd/MM/yyyy')}"),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                height: 2,
                width: size.width,
                color: Colors.black.withOpacity(.3),
              )
            ],
          )),
    );
  }
}
