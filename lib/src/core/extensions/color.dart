import 'package:flutter/material.dart' show Color;

extension ColorExtension on Color {
  Color withOpacitySafe(double opacity) {
    assert(opacity >= 0.0 && opacity <= 1.0);
    return withAlpha((255.0 * opacity).round());
  }
}
