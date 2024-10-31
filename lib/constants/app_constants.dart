import 'package:flutter/material.dart';

class AppConstants {
  // Colors

  static const Color Color1 = Color(0xFF00689D);
  static const Color Color2 = Color(0xFFEFFAFD);
  static const Color Color3 = Color(0xFF818282);

  static const Color textColor = Color(0xFF00689D);

  // Text Style

  static const TextStyle titleTextStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18.0,
      fontFamily: 'Cairo',
      color: AppConstants.Color1);

  static const TextStyle bodyTextStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14.0,
      fontFamily: 'Cairo',
      color: AppConstants.Color1);
}
