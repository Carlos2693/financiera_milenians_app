import 'package:flutter/material.dart';

class AppTheme {
  static Color buttonColor = const Color(0xFF007BFF);
  static Color buttonSelectedColor = const Color(0xFF3C00FF);
  static Color buttonPressedColor = const Color(0xFF339FFF);

  ThemeData getTheme() {
    const seedColor = Colors.deepPurple;

    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: seedColor
    );
  }
}