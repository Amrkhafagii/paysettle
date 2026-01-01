import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/utils/color_utils.dart';
import '../experience/models/experience_config.dart';
import '../experience/providers/experience_providers.dart';
import 'app_typography.dart';
import 'tokens.dart';

final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.light);

final lightThemeProvider =
    Provider<ThemeData>((ref) => _buildTheme(Brightness.light, ref));
final darkThemeProvider =
    Provider<ThemeData>((ref) => _buildTheme(Brightness.dark, ref));

ThemeData _buildTheme(Brightness brightness, WidgetRef ref) {
  final override = ref.watch(themeOverrideProvider);
  final ThemePalette? palette =
      brightness == Brightness.dark ? override?.dark : override?.light;
  final resolvedRadius = override?.cornerRadius ?? Radii.card;

  final primary = _resolveColor(palette?.primary, AppColors.brandMint500);
  final surface = _resolveColor(palette?.surface, AppColors.neutral0);
  final background =
      _resolveColor(palette?.background, AppColors.surfaceBase);
  final textPrimary = _resolveColor(
      palette?.textPrimary,
      brightness == Brightness.dark
          ? AppColors.neutral50
          : AppColors.brandMint800);
  final textSecondary =
      _resolveColor(palette?.textSecondary, AppColors.brandMint600);
  final accent = _resolveColor(palette?.accent, AppColors.chartSpending);
  final success = _resolveColor(palette?.success, AppColors.success);
  final warning = _resolveColor(palette?.warning, AppColors.warning);
  final error = _resolveColor(palette?.error, AppColors.error);

  final colorScheme = ColorScheme(
    brightness: brightness,
    primary: primary,
    onPrimary: Colors.white,
    primaryContainer: primary.withOpacity(0.1),
    onPrimaryContainer: textPrimary,
    secondary: accent,
    onSecondary: Colors.white,
    secondaryContainer: accent.withOpacity(0.12),
    onSecondaryContainer: textPrimary,
    tertiary: accent,
    onTertiary: Colors.white,
    tertiaryContainer: accent.withOpacity(0.2),
    onTertiaryContainer: AppColors.brandMint800,
    error: error,
    onError: Colors.white,
    errorContainer: error.withOpacity(0.12),
    onErrorContainer: error,
    background: background,
    onBackground: textPrimary,
    surface: surface,
    onSurface: textPrimary,
    surfaceVariant: AppColors.brandMint50,
    onSurfaceVariant: textSecondary,
    outline: AppColors.brandMint200,
    shadow: Colors.black26,
    inverseSurface: textPrimary,
    onInverseSurface: background,
    inversePrimary: primary.withOpacity(0.4),
    surfaceTint: primary,
  );

  final textTheme = AppTypography.textTheme(brightness).apply(
        bodyColor: textPrimary,
        displayColor: textPrimary,
      );

  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    colorScheme: colorScheme,
    textTheme: textTheme,
    scaffoldBackgroundColor: background,
    cardTheme: CardThemeData(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: surface,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(resolvedRadius),
      ),
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: background,
      foregroundColor: textPrimary,
      titleTextStyle:
          textTheme.titleLarge?.copyWith(color: textPrimary),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surfaceCardAlt,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(resolvedRadius),
        borderSide: BorderSide(color: AppColors.brandMint200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(resolvedRadius),
        borderSide: BorderSide(color: primary, width: 1.6),
      ),
      labelStyle: textTheme.bodyMedium?.copyWith(color: textSecondary),
    ),
    chipTheme: ChipThemeData(
      shape: StadiumBorder(
        side: BorderSide(color: AppColors.brandMint200),
      ),
      backgroundColor: AppColors.brandMint50,
      selectedColor: AppColors.brandMint200,
      labelStyle: TextStyle(color: AppColors.brandMint700),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 4,
        foregroundColor: Colors.white,
        backgroundColor: primary,
        padding: const EdgeInsets.symmetric(vertical: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(resolvedRadius),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primary,
        textStyle: textTheme.labelLarge,
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: surface,
      indicatorColor: primary.withOpacity(0.12),
      elevation: 8,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
    ),
    dividerTheme: DividerThemeData(
      color: AppColors.neutral200,
      thickness: 1,
    ),
  );
}

Color _resolveColor(String? hex, Color fallback) =>
    parseHexColor(hex, fallback: fallback);
