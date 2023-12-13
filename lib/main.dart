import 'package:dekor_farben_app/global/constants.dart';
import 'package:dekor_farben_app/global/secure_storage.dart';
import 'package:dekor_farben_app/global/theme_data.dart';
import 'package:dekor_farben_app/screens/choose_company_screen/choose_company_screen.dart';
import 'package:dekor_farben_app/screens/home_screen/home_screeen.dart';
import 'package:dekor_farben_app/screens/login_screen/components/reducer/login_reducer.dart';
import 'package:dekor_farben_app/screens/onboarding_screen/onboarding_screen.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();

  LoginReducer();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: themeData(),
    home: FutureBuilder<Widget>(
      future: isAuthenticated(),
      builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return AlertDialog(
            title: const Text("Erro inesperado, tente novamente"),
            actions: [
              TextButton(onPressed: () { Navigator.pop(context); }, child: const Text("OK"))
            ],
          );
        } else {
          return snapshot.data ?? const OnboardingScreen();
        }
      },
    ),
  ));
}

Future<Widget> isAuthenticated() async {
  if (await SecureStorage().readSecureData("jwt") != null && userType == 'user') {
    return const ChooseCompanyScreen();
  }

  if (await SecureStorage().readSecureData("jwt") != null && userType == 'company') {
    return const HomeScreen();
  }

  return const OnboardingScreen();
}
