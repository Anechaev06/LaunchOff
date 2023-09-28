import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_constants.dart';

class AppTheme {
  static final ThemeData theme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppColors.bgColor,
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryColor,
      background: AppColors.bgColor,
    ),
    textTheme: GoogleFonts.robotoMonoTextTheme()
        .copyWith(bodyLarge: const TextStyle(color: Colors.grey)),
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
}
