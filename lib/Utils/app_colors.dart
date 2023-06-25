import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xff53baef);
  static const Color whiteColor = Colors.white;
  static const Color backgroundColor = Color(0xff47549E);
  static const Color blackColor = Colors.black;
  static const Color redColor = Colors.red;
  static const Color greenColor = Colors.green;
  static Color rippleColor = Colors.deepPurple.withOpacity(0.3);
  static const Color greyColor = Colors.grey;
  static const MaterialColor blackSwatchColor = MaterialColor(
    0xFF000000,
    <int, Color>{
      50: Color(0xFFE0E0E0),
      100: Color(0xFFB3B3B3),
      200: Color(0xFF808080),
      300: Color(0xFF4D4D4D),
      400: Color(0xFF262626),
      500: Color(0xFF000000),
      600: Color(0xFF000000),
      700: Color(0xFF000000),
      800: Color(0xFF000000),
      900: Color(0xFF000000),
    },
  );
  static const Color transparentColor = Colors.transparent;
  static const Color lightGreyColor = Color(0xfff1f1f1);
  static const MaterialColor deepPurpleSwatch = MaterialColor(
    0xFF673AB7,
    {
      50: Color(0xFFF3E5F5),
      100: Color(0xFFE1BEE7),
      200: Color(0xFFCE93D8),
      300: Color(0xFFBA68C8),
      400: Color(0xFFAB47BC),
      500: Color(0xFF9C27B0),
      600: Color(0xFF8E24AA),
      700: Color(0xFF7B1FA2),
      800: Color(0xFF6A1B9A),
      900: Color(0xFF4A148C),
    },
  );
  static Color navBarTabBackGroundColor = Colors.grey[100]!;
  static Color navBarTabRippleColor = Colors.grey[300]!;
  static Color yellowColor = Colors.amber;
  static Color orangeColor = Colors.orange;
}
