import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData(
    primarySwatch: MaterialColor(0xFF008000, {
      50: Color(0xFFE0F2F1),
      100: Color(0xFFB2DFDB),
      200: Color(0xFF80CBC4),
      300: Color(0xFF4DB6AC),
      400: Color(0xFF26A69A),
      500: Color(0xFF008000),
      600: Color(0xFF00796B),
      700: Color(0xFF004D40),
      800: Color(0xFF004D40),
      900: Color(0xFF004D40),
    }),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Color(0xFF008000),
      selectionHandleColor: Color(0xFF008000),
      selectionColor: Color(0xFF008000).withOpacity(0.5),
    ),
  );

  static Color greyRectangleColor = Colors.grey; // Tambahkan ini
  static Color whiteRectangleColor = Colors.white; // Tambahkan ini
  static Color buttonBackgroundColor = Colors.black; // Tambahkan ini
  static Color buttonTextColor = Colors.white; // Tambahkan ini
}
