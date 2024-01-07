import 'package:dekor_farben_app/global/constants.dart';
import 'package:dekor_farben_app/global/widgets/app_bar_widget.dart';
import 'package:dekor_farben_app/screens/settings_screen/components/widgets/company_pic_widget.dart';
import 'package:dekor_farben_app/screens/settings_screen/components/widgets/company_settings_options_widget.dart';
import 'package:flutter/material.dart';

import '../widgets/profile_pic_widget.dart';
import '../widgets/settings_options_widget.dart';

class SettingsBody extends StatelessWidget {
  const SettingsBody({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding * 2, vertical: kDefaultPadding * 4),
      child: SingleChildScrollView(
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * .1,
                width: size.width,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AppBarWidget(title: "Configurações")
                  ],
                ),
              ),
              SizedBox(height: size.height * .02),
              SizedBox(
                width: size.width,
                child: Column(
                  children: [
                    userType == 'user' ? const ProfilePicWidget() : const CompanyPicWidget(),
                    userType == 'user' ? const SettingsOptionsWidget() : const CompanySettingsOptionsWidget()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
