import 'package:flutter/material.dart';

/// Shared border radius and shadow tokens for consistent visual styling.
class AppBorderRadius {
  const AppBorderRadius._();

  /// 10.0 — small rounding for chips, badges.
  static const double small = 10;

  /// 14.0 — medium rounding for buttons, cards.
  static const double medium = 14;

  /// 20.0 — large rounding for dialogs, sheets.
  static const double large = 20;

  /// 999.0 — pill shape for fully rounded elements.
  static const double pill = 999;

  static final BorderRadius smallAll = BorderRadius.circular(small);
  static final BorderRadius mediumAll = BorderRadius.circular(medium);
  static final BorderRadius largeAll = BorderRadius.circular(large);
  static final BorderRadius pillAll = BorderRadius.circular(pill);
}

/// Common box shadow presets.
class AppShadows {
  const AppShadows._();

  /// Subtle elevation for cards.
  static const BoxShadow cardShadow = BoxShadow(
    color: Color(0x1A000000),
    blurRadius: 6,
    offset: Offset(0, 3),
  );

  /// Medium elevation for floating elements.
  static const BoxShadow floatingShadow = BoxShadow(
    color: Color(0x26000000),
    blurRadius: 12,
    offset: Offset(0, 4),
  );
}
