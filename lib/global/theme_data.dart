import 'package:dekor_farben_app/global/constants.dart';
import 'package:flutter/material.dart';

ThemeData themeData() => ThemeData(
  scaffoldBackgroundColor: kDefaultScaffoldColor,
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      fontFamily: "Chivo",
      fontSize: 30,
      color: kDefaultTitleColor
    ),
    titleMedium: TextStyle(
        fontFamily: "Chivo",
        fontSize: 20,
        color: kDefaultSubtitleColor
    ),
    titleSmall: TextStyle(
        fontFamily: "Chivo",
        fontSize: 14,
        color: kDefaultTitleColor
    ),
  )
);