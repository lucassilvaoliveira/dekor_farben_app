import 'package:dekor_farben_app/app/decor_coins_app.dart';
import 'package:dekor_farben_app/screens/login_screen/components/reducer/login_reducer.dart';
import 'package:flutter/material.dart';
import 'package:rx_notifier/rx_notifier.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();

  LoginReducer();

  runApp(const RxRoot(child: SafeArea(child: DecorCoinsApp())));
}
