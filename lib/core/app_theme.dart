import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFF3598DB);
  static const Color backgroundLight = Color(0xFFFCFCFC);
  static const Color backgroundDark = Color(0xFF101127);
  static const Color grey = Color(0xFF7F7F7F);
  static const Color black = Color(0xFF1C1C1C);
  static const Color red = Color(0xFFFF5659);
  static const Color white = Color(0xFFFFFFFF);
  static const Color green = Colors.green;

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: backgroundLight,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: white,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        color: white,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primary,
      foregroundColor: white,
      shape: CircleBorder(),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: primary,
      ),

      enabledBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: primary),
      ),
      focusedBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: grey),
      ),
      errorBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: grey),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: grey),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(16),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primary,
        textStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
          fontStyle: FontStyle.italic,
        ),
      ),
    ),
    textTheme: TextTheme(
      headlineSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: black,
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: white,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: black,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: black,
      ),
    ),
  );
}
