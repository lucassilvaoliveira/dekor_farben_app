import 'package:dekor_farben_app/core/entities/campaign.dart';
import 'package:dekor_farben_app/core/entities/product.dart';
import 'package:dekor_farben_app/global/constants.dart';
import 'package:dekor_farben_app/screens/campaigns_screen/components/widgets/campaign_widget.dart';
import 'package:dekor_farben_app/screens/home_screen/components/widgets/page_indicator_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../campaign_registration_screen/campaign_registration_screen.dart';

class CampaignsWidget extends StatelessWidget {
  CampaignsWidget({
    super.key,
    required this.size,
  });

  final Size size;
  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.topLeft,
          child: Row(
            children: [
              Text(
                "Campanhas",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 28, fontWeight: FontWeight.bold),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: GestureDetector(
                  onTap: () => Navigator.push(context, CupertinoPageRoute(
                      builder: (context) => const CampaignRegistrationScreen())),
                  child: ClipOval(
                    child: Container(
                      width: 30,
                      height: 30,
                      color: kDefaultPrimaryColor,
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          height: 280,
          width: size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 6,
                offset: const Offset(2, 6), // changes position of shadow
              ),
            ],
          ),
          child: PageView.builder(
            itemCount: campaings.length,
            scrollDirection: Axis.horizontal,
            controller: _controller,
            itemBuilder: (_, index) => CampaignWidget(
              size: size,
              campaign: campaings[index],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        PageIndicatorWidget(controller: _controller, count: campaings.length)
      ],
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
        "Na compra de RS 10,000 em borracha líquida ganhe 1000 decor coins!",
    campaignReward: 1500,
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
        "Na compra de RS 20,000 em borracha líquida ganhe 1000 decor coins!",
    campaignReward: 8000,
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
        "Na compra de RS 30,000 em borracha líquida ganhe 1000 decor coins!",
    campaignReward: 10000,
    campaignInitialDate: DateTime.now(),
    campaignEndDate: DateTime.now(),
    campaignIsOpen: true,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
];
