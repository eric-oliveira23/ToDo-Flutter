import 'package:flutter/material.dart';

ThemeData myTheme = ThemeData(
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: const Color(0xFF4285F4),
    secondary: const Color(0xFF4285F4),
    tertiary: const Color(0xFF34A853),
  ),
  fontFamily: 'Poppins',
  textTheme: const TextTheme(
    bodyMedium: TextStyle(fontSize: 16),
    bodyLarge: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.normal,
    ),
  ),
);
