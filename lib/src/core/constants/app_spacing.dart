/// Standardized spacing scale for consistent layout spacing across the app.
///
/// Use these constants instead of raw numeric values in `SizedBox`, `Padding`,
/// `EdgeInsets`, etc. to maintain visual consistency and make global spacing
/// adjustments trivial.
class AppSpacing {
  const AppSpacing._();

  /// 2.0 - hairline dividers
  static const double micro = 2;

  /// 4.0 — hairline gaps, icon-to-text micro-spacing.
  static const double xs = 4;

  /// 8.0 — tight spacing between related elements.
  static const double s = 8;

  /// 12.0 — default gap between sibling components.
  static const double m = 12;

  /// 16.0 — standard content padding.
  static const double l = 16;

  /// 20.0 — section padding, card internal padding.
  static const double xl = 20;

  /// 24.0 — generous spacing between sections.
  static const double xxl = 24;

  /// 32.0 — large section dividers.
  static const double xxxl = 32;

  /// 40.0 - between major page sections
  static const double section = 40;

  /// 48.0 — jumbo spacing for hero sections, major separators.
  static const double jumbo = 48;
}
