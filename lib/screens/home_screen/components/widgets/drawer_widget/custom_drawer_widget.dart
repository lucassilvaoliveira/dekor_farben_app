import 'package:dekor_farben_app/global/constants.dart';
import 'package:dekor_farben_app/screens/home_screen/components/widgets/drawer_widget/company_custom_drawer_widget.dart';
import 'package:dekor_farben_app/screens/home_screen/components/widgets/drawer_widget/user_custom_drawer_widget.dart';
import 'package:dekor_farben_app/screens/onboarding_screen/onboarding_screen.dart';
import 'package:flutter/material.dart';

import '../../../../settings_screen/settings_screen.dart';
import 'menu_icon_widget.dart';

class CustomDrawerWidget extends StatelessWidget {
  final String entityName;

  const CustomDrawerWidget({super.key, required this.entityName});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: kDefaultPrimaryColor),
      padding: const EdgeInsets.only(top: 50, bottom: 70, left: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const CircleAvatar(),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entityName,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.white),
                  ),
                ],
              )
            ],
          ),
          userType == 'user' ?  const UserCustomDrawerWidget() :
                                const CompanyCustomDrawerWidget(),
          const Column(
            children: [
              MenuIconWidget(
                  destinationWidget: SettingsScreen(),
                  widgetIcon: Icons.settings,
                  widgetText: 'Configurações'),
              SizedBox(height: 10),
              MenuIconWidget(
                  destinationWidget: OnboardingScreen(),
                  widgetIcon: Icons.logout,
                  widgetText: 'Sair da conta')
            ],
          ),
        ],
      ),
    );
  }
}
