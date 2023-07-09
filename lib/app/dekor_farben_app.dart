import 'package:dekor_farben_app/global/theme_data.dart';
import 'package:dekor_farben_app/screens/login/login_screen.dart';
import 'package:flutter/material.dart';

class DekorFarbenApp extends StatelessWidget {
  const DekorFarbenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData(),
      home: const LoginScreen()
    );
  }
}