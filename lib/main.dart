import 'package:dekor_farben_app/global/theme_data.dart';
import 'package:dekor_farben_app/screens/login_screen/components/reducer/login_reducer.dart';
import 'package:dekor_farben_app/screens/onboarding_screen/onboarding_screen.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();

  LoginReducer();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: themeData(),
    home: const OnboardingScreen(),
  ));
}
