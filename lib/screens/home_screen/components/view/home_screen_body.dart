import 'package:dekor_farben_app/screens/home_screen/components/widgets/company_description_widget.dart';
import 'package:flutter/material.dart';

import '../../../../global/constants.dart';
import '../widgets/campaigns_widget.dart';
import '../widgets/coins_amount_widget.dart';
import '../widgets/drawer_widget/custom_drawer_widget.dart';
import '../widgets/recently_works_widget.dart';

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({super.key});

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  double containerRadiusWhenDrawerOpen = 0;
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  double iconSize = 20;
  bool drawerIsOpen = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(children: [
      const CustomDrawerWidget(entityName: 'Lucas Silva'),
      GestureDetector(
        onTap: () {
          if (drawerIsOpen) {
            setState(() {
              containerRadiusWhenDrawerOpen = 0;
              xOffset = 0;
              yOffset = 0;
              scaleFactor = 1;
              drawerIsOpen = false;
            });
          }
        },
        child: AnimatedContainer(
          transform: Matrix4.translationValues(xOffset, yOffset, 0)
            ..scale(scaleFactor),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
              color: kDefaultScaffoldColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(containerRadiusWhenDrawerOpen),
                  bottomLeft: Radius.circular(containerRadiusWhenDrawerOpen))),
          duration: const Duration(milliseconds: 300),
          child: Column(
            children: [
              SizedBox(height: size.height * .05),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: size.width * .7,
                    child: RichText(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: "Olá, ",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(fontSize: 25)),
                          TextSpan(
                            text: "Decor Colors - Blumenau Centro",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(1),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          containerRadiusWhenDrawerOpen = 30;
                          xOffset = 230;
                          yOffset = 150;
                          scaleFactor = 0.6;
                          drawerIsOpen = true;
                        });
                      },
                      icon: Icon(Icons.menu,
                          size: iconSize, color: kDefaultPrimaryColor),
                    ),
                  ),
                ],
              ),
              userType == 'user' ? const CompanyDescriptionWidget() : const SizedBox(height: 0),
              SizedBox(height: size.height * .016),
              Expanded(
                child: ListView(
                  children: [
                    CampaignsWidget(size: size),
                    const SizedBox(height: 50),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: [
                          Text(
                            "Trabalhos recentes",
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: GestureDetector(
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
                    const SizedBox(height: 16),
                    RecentlyWorksWidget(size: size)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ]);
  }
}
