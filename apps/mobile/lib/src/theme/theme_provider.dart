import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_typography.dart';
import 'tokens.dart';

final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.light);

final lightThemeProvider =
    Provider<ThemeData>((ref) => _buildTheme(Brightness.light));
final darkThemeProvider =
    Provider<ThemeData>((ref) => _buildTheme(Brightness.dark));

ThemeData _buildTheme(Brightness brightness) {
  final colorScheme = ColorScheme(
    brightness: brightness,
    primary: AppColors.brandMint500,
    onPrimary: Colors.white,
    primaryContainer: AppColors.brandMint100,
    onPrimaryContainer: AppColors.brandMint700,
    secondary: AppColors.brandMint400,
    onSecondary: Colors.white,
    secondaryContainer: AppColors.brandMint50,
    onSecondaryContainer: AppColors.brandMint700,
    tertiary: const Color(0xFF0ACF83),
    onTertiary: Colors.white,
    tertiaryContainer: const Color(0xFFB2FADF),
    onTertiaryContainer: AppColors.brandMint800,
    error: AppColors.error,
    onError: Colors.white,
    errorContainer: const Color(0xFFFEE3E3),
    onErrorContainer: AppColors.error,
    background: AppColors.neutral50,
    onBackground: AppColors.brandMint800,
    surface: AppColors.neutral0,
    onSurface: AppColors.brandMint800,
    surfaceVariant: AppColors.brandMint50,
    onSurfaceVariant: AppColors.brandMint600,
    outline: AppColors.brandMint200,
    shadow: Colors.black26,
    inverseSurface: AppColors.brandMint800,
    onInverseSurface: AppColors.neutral0,
    inversePrimary: AppColors.brandMint200,
    surfaceTint: AppColors.brandMint500,
  );

  final textTheme = AppTypography.textTheme(brightness);

  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    colorScheme: colorScheme,
    textTheme: textTheme,
    scaffoldBackgroundColor: AppColors.surfaceBase,
    cardTheme: CardThemeData(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: AppColors.surfaceCard,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Radii.card),
      ),
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.surfaceBase,
      foregroundColor: AppColors.brandMint800,
      titleTextStyle:
          textTheme.titleLarge?.copyWith(color: AppColors.brandMint800),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surfaceCardAlt,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Radii.card),
        borderSide: BorderSide(color: AppColors.brandMint200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Radii.card),
        borderSide: BorderSide(color: AppColors.brandMint500, width: 1.6),
      ),
      labelStyle: textTheme.bodyMedium?.copyWith(color: AppColors.brandMint700),
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
        backgroundColor: AppColors.brandMint500,
        padding: const EdgeInsets.symmetric(vertical: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Radii.button),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.brandMint700,
        textStyle: textTheme.labelLarge,
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.surfaceCard,
      indicatorColor: AppColors.brandMint100,
      elevation: 8,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
    ),
    dividerTheme: DividerThemeData(
      color: AppColors.neutral200,
      thickness: 1,
    ),
  );
}
