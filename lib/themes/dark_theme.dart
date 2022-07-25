import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFF161618),
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(secondary: Color(0xFF252528)),
    primaryColorDark: const Color(0xFF161618),
    appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF252528)),
    iconTheme: const IconThemeData(color: Color(0x33FFFFFF)),
    textTheme: const TextTheme(
      titleLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
      labelSmall:
          TextStyle(fontSize: 16, letterSpacing: 0, color: Color(0x66FFFFFF)),
      labelMedium:
          TextStyle(fontSize: 16, letterSpacing: 0, color: Colors.white),
    ));
