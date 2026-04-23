import 'package:flutter/material.dart' show Color, Colors;

extension ColorExtension on Color {
  Color withOpacitySafe(double opacity) {
    assert(opacity >= 0.0 && opacity <= 1.0);
    return withAlpha((255.0 * opacity).round());
  }
}

extension HexColorExt on String {
  Color get toColor {
    final hexCode = replaceFirst('#', '');
    final parsed = int.tryParse(hexCode, radix: 16);
    if (parsed == null) return Colors.grey;
    return Color(parsed | 0xFF000000);
  }
}
