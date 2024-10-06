import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.purple.shade50,
    primary: Colors.purple.shade100,
    secondary: Colors.purple.shade200,
    tertiary: Colors.black,
  ),
  useMaterial3: true,

);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Colors.grey.shade900,
    primary: Colors.purple.shade800,
    secondary: Colors.purple.shade900,
    tertiary: Colors.white
  ),
  useMaterial3: true,
);

