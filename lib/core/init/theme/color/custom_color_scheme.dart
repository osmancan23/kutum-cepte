import 'package:flutter/material.dart';

/// Project custom colors
final class CustomColorScheme {
  CustomColorScheme._();

  /// Light color scheme set
  static const colorScheme = ColorScheme(
    brightness: Brightness.light,
    // BUTTONS AND SOME TEXTS
    primary: Color(0xFFFB9400),
    // PRIMARY TEXTS
    onPrimary: Color(0xFF212121),
    // TEXT FIELDS AND SOME TEXTS
    primaryContainer: Color(0xFFF5F5F5),
    onPrimaryContainer: Color(0xFFFFEED4),
    // HINT TEXTS
    secondary: Color(0xFF9E9E9E),
    // WHITE TEXTS
    onSecondary: Color(0xFFFFFFFF),
    error: Color(0xFFD32F2F),
    // Scaffold background color
    onError: Color(0xffFAFAFA),
    // BACKGROUND COLOR
    surface: Color(0xFF333333),
    onSurface: Color(0xFF616161),
  );
}
