import 'package:flutter/material.dart';
import 'package:my_store/core/utils/colors.dart';

ThemeData themeDataFunc() {
  final colors = ColorsTheme();
  return ThemeData(
    scaffoldBackgroundColor: colors.whiteColor,
    primaryColor: colors.primaryDark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: colors.primaryDark,
      brightness: Brightness.light,
      onPrimary: colors.whiteColor,
      secondary: colors.secondaryColor,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: colors.whiteColor,
      foregroundColor: colors.primaryColor,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: colors.primaryDark,
        fontSize: 26,
        fontWeight: FontWeight.bold,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: colors.primaryDark,
      foregroundColor: colors.whiteColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colors.primaryDark,
        foregroundColor: colors.whiteColor,
        minimumSize: const Size(double.infinity, 50),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: EdgeInsets.all(0),
        textStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: colors.primaryColor,
        ),
      ),
    ),
    useMaterial3: true,
  );
}
