import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

/// Namespace for HulaJuan app [ThemeData].
class HulaJuanTheme {
  /// Light theme.
  static ThemeData light = FlexThemeData.light(
    scheme: FlexScheme.materialBaseline,
    blendLevel: 20,
    appBarOpacity: 0.95,
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    // fontFamily: 'Gugi',
  );

  /// Dark theme.
  static ThemeData dark = FlexThemeData.dark(
    scheme: FlexScheme.materialBaseline,
    blendLevel: 15,
    appBarOpacity: 0.90,
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    // fontFamily: 'Gugi',
  );
}
