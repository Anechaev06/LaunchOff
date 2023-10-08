import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_constants.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData theme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppColors.bgColor,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryColor,
      secondary: AppColors.secondaryColor,
      background: AppColors.bgColor,
    ),
    textTheme: textTheme,
    appBarTheme: appBarTheme,
    bottomNavigationBarTheme: bottomNavigationBarThemeData,
    listTileTheme: listTileTheme,
  );

  static const AppBarTheme appBarTheme = AppBarTheme(
    foregroundColor: AppColors.secondaryColor,
    backgroundColor: AppColors.bgColor,
    shadowColor: Colors.transparent,
    elevation: 0,
    centerTitle: true,
  );

  static const BottomNavigationBarThemeData bottomNavigationBarThemeData =
      BottomNavigationBarThemeData(
    selectedItemColor: AppColors.primaryColor,
    backgroundColor: AppColors.bgColor,
    unselectedItemColor: AppColors.accentColor,
    elevation: 0,
    type: BottomNavigationBarType.fixed,
    showSelectedLabels: false,
    showUnselectedLabels: false,
  );

  static TextTheme textTheme = GoogleFonts.robotoMonoTextTheme().copyWith(
    // HeadLine
    headlineMedium: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.secondaryColor),

    // Title
    titleMedium: const TextStyle(
        fontWeight: FontWeight.bold, color: AppColors.secondaryColor),

    // Label
    labelMedium: const TextStyle(
        color: AppColors.secondaryColor, fontWeight: FontWeight.bold),

    // Body
    bodyLarge: const TextStyle(fontSize: 16, color: AppColors.accentColor),
    bodyMedium: const TextStyle(fontSize: 14, color: AppColors.accentColor),
    bodySmall: const TextStyle(fontSize: 12, color: AppColors.secondaryColor),
  );

  static final ListTileThemeData listTileTheme = ListTileThemeData(
    dense: false,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    titleTextStyle: textTheme.titleSmall,
    subtitleTextStyle: textTheme.bodyMedium,
  );
}
