import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  buttonTheme: const ButtonThemeData(buttonColor: ConstDarkColors.colorBlue),
  scaffoldBackgroundColor: ConstDarkColors.backPrimary,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    secondary: ConstDarkColors.backSecondary,
    background: Colors.grey.shade900,
  ),
  primaryColorDark: ConstDarkColors.backPrimary,
  appBarTheme:
      const AppBarTheme(backgroundColor: ConstDarkColors.backSecondary),
  iconTheme: const IconThemeData(color: ConstDarkColors.supportSeparator),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: ConstDarkColors.colorBlue,
  ),
  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return ConstDarkColors.colorBlue;
      } else {
        return ConstDarkColors.backElevated;
      }
    }),
    trackColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return ConstDarkColors.colorBlue.withOpacity(0.3);
      } else {
        return ConstDarkColors.supportOverlay;
      }
    }),
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
    labelSmall: TextStyle(
      fontSize: 14,
      letterSpacing: 0,
      color: ConstDarkColors.labelTertiary,
    ),
    labelMedium: TextStyle(
        fontSize: 16, letterSpacing: 0, color: ConstDarkColors.labelTertiary),
    titleMedium: TextStyle(
        fontSize: 16, letterSpacing: 0, color: ConstDarkColors.labelPrimary),
    displaySmall: TextStyle(color: ConstDarkColors.colorRed),
    displayMedium: TextStyle(color: ConstDarkColors.colorGreen),
    displayLarge: TextStyle(color: ConstDarkColors.colorBlue),
  ),
);

ThemeData lightTheme = ThemeData(
  buttonTheme: const ButtonThemeData(buttonColor: ConstLightColors.colorBlue),
  scaffoldBackgroundColor: ConstLightColors.backPrimary,
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    secondary: ConstLightColors.backSecondary,
    background: Colors.grey.shade800,
  ),
  primaryColorDark: ConstLightColors.backPrimary,
  appBarTheme:
      const AppBarTheme(backgroundColor: ConstLightColors.backSecondary),
  iconTheme: const IconThemeData(color: ConstLightColors.supportSeparator),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: ConstLightColors.colorBlue,
  ),
  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return ConstLightColors.colorBlue;
      } else {
        return ConstLightColors.backElevated;
      }
    }),
    trackColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return ConstLightColors.colorBlue.withOpacity(0.3);
      } else {
        return ConstLightColors.supportOverlay;
      }
    }),
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
    labelSmall: TextStyle(
      fontSize: 14,
      letterSpacing: 0,
      color: ConstLightColors.labelTertiary,
    ),
    labelMedium: TextStyle(
        fontSize: 16, letterSpacing: 0, color: ConstLightColors.labelTertiary),
    titleMedium: TextStyle(
        fontSize: 16, letterSpacing: 0, color: ConstLightColors.labelPrimary),
    displaySmall: TextStyle(color: ConstLightColors.colorRed),
    displayMedium: TextStyle(color: ConstLightColors.colorGreen),
    displayLarge: TextStyle(color: ConstLightColors.colorBlue),
  ),
);

class ConstDarkColors {
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

class ConstLightColors {
  static const supportSeparator = Color(0x33000000);
  static const supportOverlay = Color(0x0F000000);

  static const labelPrimary = Colors.black;
  static const labelSecondary = Color(0x99000000);
  static const labelTertiary = Color(0x4D000000);
  static const labelDisable = Color(0x26000000);

  static const colorRed = Color(0xFFFF3B30);
  static const colorGreen = Color(0xFF34C759);
  static const colorBlue = Color(0xFF007AFF);
  static const colorGray = Color(0xFF8E8E93);
  static const colorGrayLight = Color(0xFFD1D1D6);
  static const colorWhite = Colors.white;

  static const backPrimary = Color(0xFFF7F6F2);
  static const backSecondary = Colors.white;
  static const backElevated = Colors.white;
}
