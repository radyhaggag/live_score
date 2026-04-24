import 'package:flutter/material.dart';

import '../extensions/context_ext.dart';

/// Shared border radius and shadow tokens for consistent visual styling.
class AppBorderRadius {
  const AppBorderRadius._();

  /// 8.0 - chip
  static const double chip = 8;

  /// 10.0 — small rounding for chips, badges.
  static const double small = 10;

  /// 14.0 — medium rounding for buttons, cards.
  static const double medium = 14;

  /// 16.0 - standard card
  static const double card = 16;

  /// 20.0 — large rounding for dialogs, sheets.
  static const double large = 20;

  /// 999.0 — pill shape for fully rounded elements.
  static const double pill = 999;

  static final BorderRadius chipAll = BorderRadius.circular(chip);
  static final BorderRadius smallAll = BorderRadius.circular(small);
  static final BorderRadius mediumAll = BorderRadius.circular(medium);
  static final BorderRadius cardAll = BorderRadius.circular(card);
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

  /// Elevated shadow for floating elements like FABs.
  static const BoxShadow elevatedShadow = BoxShadow(
    color: Color(0x33000000),
    blurRadius: 16,
    offset: Offset(0, 8),
  );

  /// Factory for colored glow effects on live cards
  static BoxShadow glowShadow(Color color) {
    return BoxShadow(
      color: color.withValues(alpha: 0.4),
      blurRadius: 12,
      spreadRadius: 2,
      offset: const Offset(0, 4),
    );
  }
}

class AppDecorations {
  const AppDecorations._();

  static BoxDecoration glassMorphism(BuildContext context) {
    return BoxDecoration(
      color: context.colorsExt.surfaceGlass,
      borderRadius: AppBorderRadius.cardAll,
      border: Border.all(
        color: context.colors.onSurface.withValues(alpha: 0.1),
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
          color: context.colors.onSurface.withValues(alpha: 0.05),
          blurRadius: 10,
          spreadRadius: -5,
        ),
      ],
    );
  }

  static BoxDecoration gradientCard(Gradient gradient) {
    return BoxDecoration(
      gradient: gradient,
      borderRadius: AppBorderRadius.cardAll,
      boxShadow: const [AppShadows.cardShadow],
    );
  }
}
