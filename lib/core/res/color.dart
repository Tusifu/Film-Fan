import 'package:flutter/material.dart';

class AppColors {
  static bool isDarkMode = true;

  static Color get primaryColor => Colors.white;
  static MaterialColor get primarySwatch => Colors.indigo;
  static Color get accentColor => isDarkMode ? primaryColor : Colors.grey[600]!;
  static Color get bgColor => isDarkMode ? Colors.black : Colors.grey[50]!;

  static ThemeData get getTheme => ThemeData(
        primaryColor: primaryColor,
        primarySwatch: primarySwatch,
        appBarTheme: AppBarTheme(
          backgroundColor: bgColor,
          iconTheme: IconThemeData(
            color: Colors.grey[500],
          ),
          elevation: 0,
          foregroundColor: Colors.grey[600],
        ),
        colorScheme: const ColorScheme.light(),
        backgroundColor: bgColor,
        textTheme: TextTheme(
          displayMedium: TextStyle(
            color: Colors.blueGrey[800],
            fontWeight: FontWeight.w800,
            fontSize: 28,
          ),
          displaySmall: TextStyle(
            color: Colors.blueGrey[800],
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
          labelMedium: TextStyle(
            color: Colors.grey[600],
            fontWeight: FontWeight.w600,
          ),
        ),
        scaffoldBackgroundColor: bgColor,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
        ),
      );
}
