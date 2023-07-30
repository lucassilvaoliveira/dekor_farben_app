import 'package:dekor_farben_app/core/entities/campaign.dart';
import 'package:dekor_farben_app/screens/campaign_details_screen/components/widgets/campaign_product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CampaignDetailsBody extends StatelessWidget {
  final Campaign campaign;
  const CampaignDetailsBody({super.key, required this.campaign});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            height: size.height * .25,
            width: size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Campanha ${campaign.campaignName}',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontSize: 30),
                ),
                SizedBox(height: size.height * .04),
                Text(
                  campaign.campaignDescription,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontSize: 20),
                )
              ],
            ),
          ),
          SizedBox(
            height: size.height * .7,
            width: size.width,
            child: campaign.products.isEmpty
                ? SizedBox(
                    height: size.height,
                    width: size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/images/no-data-img.svg",
                          width: size.width * .3,
                        ),
                        Text(
                          "Esta campanha não possui nenhum produto!",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium,
                        )
                      ],
                    ),
                  )
                : ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    itemCount: campaign.products.length,
                    itemBuilder: (_, index) => CampaignProductWidget(
                      size: size,
                      product: campaign.products[index],
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
