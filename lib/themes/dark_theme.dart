import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  buttonTheme: const ButtonThemeData(buttonColor: ConstColors.colorBlue),
  scaffoldBackgroundColor: ConstColors.backPrimary,
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(secondary: ConstColors.backSecondary),
  primaryColorDark: ConstColors.backPrimary,
  appBarTheme: const AppBarTheme(backgroundColor: ConstColors.backSecondary),
  iconTheme: const IconThemeData(color: ConstColors.supportSeparator),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: ConstColors.colorBlue,
  ),
  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return ConstColors.colorBlue;
      } else {
        return ConstColors.backElevated;
      }
    }),
    trackColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return ConstColors.colorBlue.withOpacity(0.3);
      } else {
        return ConstColors.supportOverlay;
      }
    }),
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
    labelSmall: TextStyle(
      fontSize: 14,
      letterSpacing: 0,
      color: ConstColors.labelTertiary,
    ),
    labelMedium: TextStyle(
        fontSize: 16, letterSpacing: 0, color: ConstColors.labelTertiary),
    titleMedium: TextStyle(
        fontSize: 16, letterSpacing: 0, color: ConstColors.labelPrimary),
  ),
);

class ConstColors {
  static const supportSeparator = Color(0x33FFFFFF);
  static const supportOverlay = Color(0x52000000);

  static const labelPrimary = Colors.white;
  static const labelSecondary = Color(0x99FFFFFF);
  static const labelTertiary = Color(0x66FFFFFF);
  static const labelDisable = Color(0x26FFFFFF);

  static const colorRed = Color(0xFFFF453A);
  static const colorGreen = Color(0xFF32D74B);
  static const colorBlue = Color(0xFF0A84FF);
  static const colorGray = Color(0xFF8E8E93);
  static const colorGrayLight = Color(0xFF48484A);
  static const colorWhite = Colors.white;

  static const backPrimary = Color(0xFF161618);
  static const backSecondary = Color(0xFF252528);
  static const backElevated = Color(0xFF3C3C3F);
}
