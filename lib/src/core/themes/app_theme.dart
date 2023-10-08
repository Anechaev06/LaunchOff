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
    bottomNavigationBarTheme: bottomNavigationBarTheme,
    listTileTheme: listTileTheme,
    popupMenuTheme: popupMenuTheme,
  );

  static const AppBarTheme appBarTheme = AppBarTheme(
    titleTextStyle: TextStyle(fontSize: 26),
    foregroundColor: AppColors.secondaryColor,
    backgroundColor: AppColors.bgColor,
    shadowColor: Colors.transparent,
    elevation: 0,
    centerTitle: true,
  );

  static const BottomNavigationBarThemeData bottomNavigationBarTheme =
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
    headlineLarge: const TextStyle(
      fontSize: 96,
      fontWeight: FontWeight.w300,
      color: AppColors.primaryColor,
    ),
    headlineMedium: const TextStyle(
      fontSize: 60,
      fontWeight: FontWeight.w300,
      color: AppColors.primaryColor,
    ),
    headlineSmall: const TextStyle(
      fontSize: 48,
      fontWeight: FontWeight.w400,
      color: AppColors.primaryColor,
    ),
    // Title
    titleLarge: const TextStyle(
      fontSize: 34,
      fontWeight: FontWeight.w400,
      color: AppColors.primaryColor,
    ),
    titleMedium: const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      color: AppColors.primaryColor,
    ),
    titleSmall: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: AppColors.primaryColor,
    ),
    // Label
    labelLarge: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      color: AppColors.secondaryColor,
    ),
    labelMedium: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      color: AppColors.secondaryColor,
    ),
    labelSmall: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      color: AppColors.secondaryColor,
    ),
    // Body
    bodyLarge: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColors.accentColor,
    ),
    bodyMedium: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.accentColor,
    ),
    bodySmall: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppColors.accentColor,
    ),
  );

  static final ListTileThemeData listTileTheme = ListTileThemeData(
    titleTextStyle: textTheme.titleSmall,
    subtitleTextStyle: textTheme.bodyMedium,
  );

  static const PopupMenuThemeData popupMenuTheme = PopupMenuThemeData(
    iconColor: AppColors.accentColor,
    surfaceTintColor: AppColors.bgColor,
    elevation: 0,
  );
}
