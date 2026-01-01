import 'package:flutter/material.dart';

Color parseHexColor(String? value, {Color fallback = Colors.grey}) {
  if (value == null || value.isEmpty) {
    return fallback;
  }
  final sanitized = value.replaceFirst('#', '');
  final buffer = StringBuffer();
  if (sanitized.length == 6) {
    buffer.write('FF');
  }
  buffer.write(sanitized);
  final hex = int.tryParse(buffer.toString(), radix: 16);
  if (hex == null) {
    return fallback;
  }
  return Color(hex);
}
