import 'package:dekor_farben_app/app/dekor_farben_app.dart';
import 'package:dekor_farben_app/screens/login/components/reducer/login_reducer.dart';
import 'package:flutter/material.dart';
import 'package:rx_notifier/rx_notifier.dart';

void main(List<String> args) {

  WidgetsFlutterBinding.ensureInitialized();

  LoginReducer();

  runApp(const RxRoot(child: DekorFarbenApp()));
}