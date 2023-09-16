import 'package:dekor_farben_app/global/constants.dart';
import 'package:dekor_farben_app/screens/home_screen/components/widgets/admin_screen_content.dart';
import 'package:dekor_farben_app/screens/home_screen/components/widgets/custom_drawer_widget.dart';
import 'package:dekor_farben_app/screens/home_screen/components/widgets/user_screen_content.dart';
import 'package:flutter/material.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        CustomDrawerWidget(),
        userType == "admin" ? AdminScreenContent() : UserScreenContent(),
      ],
    );
  }
}
