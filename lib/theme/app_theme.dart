import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFF2E7D32);
  static const Color accent = Color(0xFFA5D6A7);
  static const Color background = Color(0xFFF8FAF9);
  static const Color surface = Colors.white;
  static const Color textDark = Color(0xFF1C1C1C);
  static const Color textLight = Color(0xFF6F6F6F);

  static ThemeData theme = ThemeData(
    scaffoldBackgroundColor: background,
    primaryColor: primary,
    fontFamily: 'Roboto',
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: textDark),
      titleTextStyle: TextStyle(
        color: textDark,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}
