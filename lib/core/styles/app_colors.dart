import 'package:flutter/material.dart';

abstract class AppColors {
  static const MaterialColor primarySwatchLight = MaterialColor(
    0xFFdc3545,
    <int, Color>{
      50: Color(0xFFffecf1),
      100: Color(0xFFffd0d9),
      200: Color(0xFFf19ea6),
      300: Color(0xFFe97984),
      400: Color(0xFFf75965),
      500: Color(0xFFfd464e),
      600: Color(0xFFef3e4d),
      700: Color(0xFFdc3546),
      800: Color(0xFFcf2e3e),
      900: Color(0xFFc02333),
    },
  );

  static const MaterialColor primarySwatchDark = MaterialColor(
    0xFF6235dc,
    <int, Color>{
      50: Color(0xFFeee7fb),
      100: Color(0xFFd3c4f4),
      200: Color(0xFFb59dee),
      300: Color(0xFF9674e8),
      400: Color(0xFF7d55e2),
      500: Color(0xFF6235dc),
      600: Color(0xFF5630d6),
      700: Color(0xFF4428cd),
      800: Color(0xFF3122c6),
      900: Color(0xFF0014bc),
    },
  );

  static ColorScheme colorSchemeLight = const ColorScheme.light().copyWith(
    primary: Colors.purple,
    secondary: Colors.deepOrange,
  );

  static ColorScheme colorSchemeDark = const ColorScheme.dark();
}
