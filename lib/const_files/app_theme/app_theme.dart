import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData appThemeData =  ThemeData(
    colorScheme:  ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
    useMaterial3: true,
  );
}
