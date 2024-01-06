import 'package:dekor_farben_app/blocs/campaign/campaign_bloc.dart';
import 'package:dekor_farben_app/blocs/company/company_state.dart';
import 'package:dekor_farben_app/blocs/user/user_state.dart';
import 'package:dekor_farben_app/core/entities/company.dart';
import 'package:dekor_farben_app/core/entities/user.dart';
import 'package:dekor_farben_app/screens/choose_company_screen/components/reducer/global_company_store.dart';
import 'package:dekor_farben_app/screens/home_screen/components/widgets/company_description_widget.dart';
import 'package:dekor_farben_app/screens/onboarding_screen/components/reducer/global_user_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../../../blocs/recent_work/recent_work_bloc.dart';
import '../../../../global/constants.dart';
import '../widgets/campaigns_widget.dart';
import '../widgets/drawer_widget/custom_drawer_widget.dart';
import '../widgets/recently_works_widget.dart';

class HomeScreenBody extends StatefulWidget {
  final Company company;

  const HomeScreenBody({super.key, required this.company});

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
    return StoreConnector<UserGetOneSuccessState, User>(
        converter: (store) => store.state.user,
        builder: (context, user) {
          return userType == 'user' ? userHome(size, context, user) : companyHome(size, context, widget.company);
        }
    );
  }

  Stack userHome(final Size size, final BuildContext context, final User user) {
    return Stack(children: [
          CustomDrawerWidget(entityName: user.userName),
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
                      StoreProvider<CompanyGetOneSuccessState>(
                        store: GlobalCompanyStore.store,
                        child: StoreProvider<UserGetOneSuccessState>(
                            store: GlobalUserStore.store,
                            child: userType == "user"
                                ? _userWelcomeMessage(context, size, user)
                                : _companyWelcomeMessage(context, size, widget.company)),
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
                  StoreProvider<CompanyGetOneSuccessState>(
                      store: GlobalCompanyStore.store,
                      child: CompanyDescriptionWidget(user: user)
                  ),
                  SizedBox(height: size.height * .016),
                  Expanded(
                    child: ListView(
                      children: [
                        BlocProvider<CampaignBloc>(
                          create: (context) => CampaignBloc(),
                          child:
                          CampaignsWidget(size: size, company: widget.company),
                        ),
                        const SizedBox(height: 50),
                        BlocProvider<RecentWorkBloc>(
                          create: (context) => RecentWorkBloc(),
                          child: RecentlyWorksWidget(
                              recentWorks: widget.company.recentWorks),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ]);
  }

  Stack companyHome(final Size size, final BuildContext context, final Company company) {
    return Stack(children: [
      CustomDrawerWidget(entityName: company.companyName),
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
                  StoreProvider<CompanyGetOneSuccessState>(
                    store: GlobalCompanyStore.store,
                    child: StoreProvider<UserGetOneSuccessState>(
                        store: GlobalUserStore.store,
                        child: _companyWelcomeMessage(context, size, company)
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
              SizedBox(height: size.height * .016),
              Expanded(
                child: ListView(
                  children: [
                    BlocProvider<CampaignBloc>(
                      create: (context) => CampaignBloc(),
                      child:
                      CampaignsWidget(size: size, company: widget.company),
                    ),
                    const SizedBox(height: 50),
                    BlocProvider<RecentWorkBloc>(
                      create: (context) => RecentWorkBloc(),
                      child: RecentlyWorksWidget(
                          recentWorks: widget.company.recentWorks),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ]);
  }

  Widget _userWelcomeMessage(final BuildContext context, final Size size, final User user) {
          return SizedBox(
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
                      text: user.userName,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              )
          );
  }

  Widget _companyWelcomeMessage(final BuildContext context, final Size size, final Company company) {
          return SizedBox(
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
                      text: company.companyName,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                    )
                  ],
                ),
              )
          );
  }
}
