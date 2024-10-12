import 'package:flutter/material.dart';


ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    primary: Color(0xfffbfbfe),
    secondary: Color(0xff2f27ce),
    onSecondary: Color(0xffeae9fc),
    onSecondaryContainer: Color(0xff4b4b4b),
    tertiary: Color(0xff040316),
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    primary: Color(0xff010104),
    secondary: Color(0xff3a31d8),
    onSecondary: Color(0xffeae9fc),
    onSecondaryContainer: Color(0xffa5a5a5),
    tertiary: Color(0xffeae9fc),
  )
);