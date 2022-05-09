import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.green,
    colorScheme: const ColorScheme.light(
      primary: Color.fromRGBO(19, 136, 8, 1),
      onPrimary: Colors.white,
      primaryContainer: Color(0xFF000000),
      secondary: Color(0xFF7CFC00),
      onSecondary: Colors.white,
      secondaryContainer: Colors.black,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.green,
    colorScheme: const ColorScheme.dark(
      primary: Color.fromRGBO(19, 136, 8, 1),
      onPrimary: Colors.black,
      primaryContainer: Colors.white,
      secondary: Color(0xFF004225),
      onSecondary: Colors.black,
      secondaryContainer: Colors.white,
    ),
  );
}
