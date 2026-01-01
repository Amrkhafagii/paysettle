import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  const AppTypography._();

  static TextTheme textTheme(Brightness brightness) {
    final base = brightness == Brightness.dark
        ? ThemeData.dark().textTheme
        : ThemeData.light().textTheme;

    return TextTheme(
      displayLarge: _workSans(base.displayLarge, size: 57, height: 64),
      displayMedium: _workSans(base.displayMedium, size: 45, height: 52),
      headlineLarge: _workSans(base.headlineLarge, size: 32, height: 40),
      headlineMedium: _workSans(base.headlineMedium, size: 28, height: 36),
      titleLarge: _workSans(base.titleLarge, size: 22, height: 28),
      titleMedium: _workSans(base.titleMedium, size: 18, height: 24),
      titleSmall: _workSans(base.titleSmall, size: 16, height: 22),
      bodyLarge: _manrope(base.bodyLarge,
          size: 16, height: 22, weight: FontWeight.w500),
      bodyMedium: _manrope(base.bodyMedium,
          size: 14, height: 20, weight: FontWeight.w500),
      bodySmall: _manrope(base.bodySmall,
          size: 12, height: 16, weight: FontWeight.w500),
      labelLarge: _manrope(base.labelLarge,
          size: 14, height: 20, weight: FontWeight.w600),
      labelMedium: _manrope(base.labelMedium,
          size: 12, height: 16, weight: FontWeight.w600),
      labelSmall: _manrope(base.labelSmall,
          size: 11, height: 16, weight: FontWeight.w600),
    );
  }

  static TextStyle _workSans(TextStyle? base,
      {required double size,
      required double height,
      FontWeight weight = FontWeight.w600}) {
    return GoogleFonts.workSans(
      textStyle: (base ?? const TextStyle()).copyWith(
        fontSize: size,
        fontWeight: weight,
        height: height / size,
        letterSpacing: 0,
      ),
    );
  }

  static TextStyle _manrope(
    TextStyle? base, {
    required double size,
    required double height,
    FontWeight weight = FontWeight.w500,
  }) {
    return GoogleFonts.manrope(
      textStyle: (base ?? const TextStyle()).copyWith(
        fontSize: size,
        fontWeight: weight,
        height: height / size,
        letterSpacing: 0,
      ),
    );
  }
}
