import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  // Brand ramp
  static const Color brandMint50 = Color(0xFFF3FBF5);
  static const Color brandMint100 = Color(0xFFE0F6E5);
  static const Color brandMint200 = Color(0xFFC0ECCB);
  static const Color brandMint300 = Color(0xFF9ADFAF);
  static const Color brandMint400 = Color(0xFF6FCE90);
  static const Color brandMint500 = Color(0xFF29A961);
  static const Color brandMint600 = Color(0xFF1F8A4F);
  static const Color brandMint700 = Color(0xFF176A3C);
  static const Color brandMint800 = Color(0xFF0F4D2A);
  static const Color brandMint900 = Color(0xFF0A371D);

  // Neutral ramp
  static const Color neutral0 = Color(0xFFFFFFFF);
  static const Color neutral50 = Color(0xFFF7F8F6);
  static const Color neutral100 = Color(0xFFEDF0EE);
  static const Color neutral200 = Color(0xFFD9DDD9);
  static const Color neutral300 = Color(0xFFC5CBC5);
  static const Color neutral400 = Color(0xFFA7ADA7);
  static const Color neutral500 = Color(0xFF889088);
  static const Color neutral600 = Color(0xFF5E665E);
  static const Color neutral700 = Color(0xFF404840);
  static const Color neutral800 = Color(0xFF232B23);
  static const Color neutral900 = Color(0xFF111611);

  // Semantic
  static const Color success = Color(0xFF0F9D58);
  static const Color warning = Color(0xFFF4AF41);
  static const Color error = Color(0xFFE64646);
  static const Color info = Color(0xFF2F7BFF);

  // Surfaces
  static const Color surfaceBase = Color(0xFFF9FBF8);
  static const Color surfaceCard = Color(0xFFFFFFFF);
  static const Color surfaceCardAlt = Color(0xFFF3F7F2);
  static const Color surfaceAccent = Color(0xFFE6F6E8);

  // Charts
  static const Color chartSpending = Color(0xFF0ACF83);
  static const Color chartSettlement = Color(0xFF06B66E);
  static const Color chartWalletPositive = Color(0xFF1AC96C);
  static const Color chartWalletNegative = Color(0xFFFF4D62);
}

class Spacing {
  const Spacing._();

  static const double xxs = 4;
  static const double xs = 4;
  static const double sm = 8;
  static const double smPlus = 12;
  static const double md = 16;
  static const double mdPlus = 20;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 40;
  static const double xxxl = 48;
}

class Radii {
  const Radii._();

  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 24;
  static const double pill = 999;

  static const double card = lg;
  static const double chip = 20;
  static const double button = 24;
}

class AppShadows {
  const AppShadows._();

  static const List<BoxShadow> level1 = [
    BoxShadow(
      color: Color(0x1A0F4D1F),
      blurRadius: 16,
      offset: Offset(0, 8),
    ),
  ];

  static const List<BoxShadow> level2 = [
    BoxShadow(
      color: Color(0x120F4D24),
      blurRadius: 24,
      offset: Offset(0, 16),
    ),
  ];
}
