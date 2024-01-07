import 'package:dekor_farben_app/blocs/campaign/campaign_bloc.dart';
import 'package:dekor_farben_app/blocs/campaign/campaign_event.dart';
import 'package:dekor_farben_app/blocs/campaign/campaign_state.dart';
import 'package:dekor_farben_app/core/entities/campaign.dart';
import 'package:dekor_farben_app/core/entities/company.dart';
import 'package:dekor_farben_app/core/entities/product.dart';
import 'package:dekor_farben_app/global/constants.dart';
import 'package:dekor_farben_app/screens/campaigns_screen/components/widgets/campaign_widget.dart';
import 'package:dekor_farben_app/screens/home_screen/components/widgets/page_indicator_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../campaign_registration_screen/campaign_registration_screen.dart';

class CampaignsWidget extends StatefulWidget {
  const CampaignsWidget({
    super.key,
    required this.size,
    required this.company
  });

  final Size size;
  final Company company;

  @override
  State<CampaignsWidget> createState() => _CampaignsWidgetState();
}

class _CampaignsWidgetState extends State<CampaignsWidget> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CampaignBloc>(context).add(GetCompanyCampaignsEvent(companyId: widget.company.id));
  }

  @override
  Widget build(BuildContext context) {
    final Size size = widget.size;

    return BlocBuilder<CampaignBloc, CampaignState>(
        builder: (BuildContext context, state) {
          if (state is CampaignGetLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CampaignGetSuccessState) {
            final controller = PageController();
            final List<Campaign> campaigns = state.campaigns;

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
                      userType == 'company' ? Container(
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
                      ) : const SizedBox()
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
                  child: campaigns.isNotEmpty ? PageView.builder(
                    itemCount: campaigns.length,
                    scrollDirection: Axis.horizontal,
                    controller: controller,
                    itemBuilder: (_, index) => CampaignWidget(
                      size: size,
                      campaign: campaigns[index],
                    ),
                  ) : Padding(
                    padding: const EdgeInsets.all(50),
                    child: SvgPicture.asset("assets/images/no-data-img.svg"),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                campaigns.isNotEmpty ? PageIndicatorWidget(
                    controller: controller, count: campaigns.length) : const SizedBox.shrink(),
                const SizedBox(height: 20)
              ],
            );
          } else {
            return const SizedBox.shrink();
          }
        }
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

List<Campaign> campaingss = [
  Campaign(
    id: uuid.v4(),
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
