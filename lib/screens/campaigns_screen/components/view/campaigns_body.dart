import 'package:dekor_farben_app/core/entities/campaign.dart';
import 'package:dekor_farben_app/core/entities/product.dart';
import 'package:dekor_farben_app/global/constants.dart';
import 'package:dekor_farben_app/screens/campaigns_screen/components/widgets/campaign_widget.dart';
import 'package:flutter/material.dart';

class CampaignsBody extends StatelessWidget {
  const CampaignsBody({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * .2,
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Campanhas",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    "Nesta tela você poderá ver as campanhas que a empresa está disponibilizando.",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            SizedBox(height: size.width * .02),
            SizedBox(
              height: size.height * .7,
              width: size.width,
              child: ListView.separated(
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemCount: campaings.length,
                itemBuilder: (_, index) => CampaignWidget(
                  size: size,
                  campaign: campaings[index],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

List<String> productNames = [
  "Pincel",
  "Lápis",
  "Borracha Líquida",
  "Tinta",
  "Fita adesiva",
  "Diamante Negro",
  "Mármore Italiano",
  "Rolo de tinta",
  "Luvas",
  "Máscara",
];

List<Campaign> campaings = [
  Campaign(
    id: uuid.v4(),
    creatorId: uuid.v4(),
    campaignParticipantsId: [],
    products: List.generate(
      10,
      (index) => Product(
        id: uuid.v4(),
        companyId: uuid.v4(),
        productPrice: 100,
        productDescription:
            "Lorem ipsum dolor sit amet consectetur adipisicing elit. Vel reiciendis cum pariatur in quod nulla cupiditate, ut sapiente, numquam ad dolores aperiam animi autem expedita eveniet? Similique nisi sit optio!",
        productName: productNames[index],
        productImagePath: "assets/images/github-logo.png",
        productAmount: 0,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ),
    campaignName: "Setembro amarelo",
    campaignDescription:
        "Na compra de RS 10,000 em borracha líquida ganhe 1000 dekor coins!",
    campaignReward: 0,
    campaignInitialDate: DateTime.now(),
    campaignEndDate: DateTime.now(),
    campaignIsOpen: true,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Campaign(
    id: uuid.v4(),
    creatorId: uuid.v4(),
    campaignParticipantsId: [],
    products: List.generate(
      10,
      (index) => Product(
        id: uuid.v4(),
        companyId: uuid.v4(),
        productPrice: 100,
        productDescription:
            "Lorem ipsum dolor sit amet consectetur adipisicing elit. Vel reiciendis cum pariatur in quod nulla cupiditate, ut sapiente, numquam ad dolores aperiam animi autem expedita eveniet? Similique nisi sit optio!",
        productName: productNames[index],
        productImagePath: null,
        productAmount: 0,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ),
    campaignName: "Outubro Rosa",
    campaignDescription:
        "Na compra de RS 10,000 em borracha líquida ganhe 1000 dekor coins!",
    campaignReward: 0,
    campaignInitialDate: DateTime.now(),
    campaignEndDate: DateTime.now(),
    campaignIsOpen: false,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Campaign(
    id: uuid.v4(),
    creatorId: uuid.v4(),
    campaignParticipantsId: [],
    products: [],
    campaignName: "Novembro Azul",
    campaignDescription:
        "Na compra de RS 10,000 em borracha líquida ganhe 1000 dekor coins!",
    campaignReward: 0,
    campaignInitialDate: DateTime.now(),
    campaignEndDate: DateTime.now(),
    campaignIsOpen: true,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
];
