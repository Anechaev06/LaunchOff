import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_constants.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData theme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppColors.bgColor,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryColor,
      background: AppColors.bgColor,
    ),
    textTheme: textTheme,
    appBarTheme: appBarTheme,
    bottomNavigationBarTheme: bottomNavigationBarThemeData,
  );

  static const AppBarTheme appBarTheme = AppBarTheme(
    color: AppColors.bgColor,
    elevation: 0,
    centerTitle: true,
  );

  static const BottomNavigationBarThemeData bottomNavigationBarThemeData =
      BottomNavigationBarThemeData(
    selectedItemColor: AppColors.primaryColor,
    backgroundColor: AppColors.bgColor,
    elevation: 0,
    type: BottomNavigationBarType.fixed,
    showSelectedLabels: false,
    showUnselectedLabels: false,
  );

  static TextTheme textTheme = GoogleFonts.robotoMonoTextTheme().copyWith(
    bodyLarge: const TextStyle(color: Colors.white),
    bodyMedium: const TextStyle(color: Colors.white),
    bodySmall: const TextStyle(color: Colors.white),
    titleMedium: const TextStyle(color: Colors.white),
  );
}
