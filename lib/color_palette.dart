import 'package:flutter/material.dart';

class LightModeColorPalette{
  Color backgroundColor = const Color(0xfffbfbfe);
  Color panelColor = const Color(0xff2f27ce);
  Color textColor = const Color(0xff040316);
}

class DarkModeColorPalette{
  Color backgroundColor = const Color(0xff010104);
  Color panelColor = const Color(0xff3a31d8);
  Color textColor = const Color(0xffeae9fc);
}

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    primary: Color(0xfffbfbfe),
    secondary: Color(0xff2f27ce),
    onSecondary: Color(0xffeae9fc),
    tertiary: Color(0xff040316),
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    primary: Color(0xff010104),
    secondary: Color(0xff3a31d8),
    onSecondary: Color(0xffeae9fc),
    tertiary: Color(0xffeae9fc),
  )
);