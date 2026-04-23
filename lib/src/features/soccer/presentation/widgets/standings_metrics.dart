/// Responsive metrics used by standings table items and headers.
class StandingsMetrics {
  const StandingsMetrics({
    required this.teamColumnWidth,
    required this.statColumnWidth,
    required this.formColumnWidth,
    required this.rankBadgeSize,
    required this.teamLogoSize,
    required this.formIndicatorSize,
    required this.formSpacing,
    required this.horizontalPadding,
    required this.verticalPadding,
    required this.headerHorizontalPadding,
    required this.headerVerticalPadding,
    required this.teamContentSpacing,
  });

  final double teamColumnWidth;
  final double statColumnWidth;
  final double formColumnWidth;
  final double rankBadgeSize;
  final double teamLogoSize;
  final double formIndicatorSize;
  final double formSpacing;
  final double horizontalPadding;
  final double verticalPadding;
  final double headerHorizontalPadding;
  final double headerVerticalPadding;
  final double teamContentSpacing;

  factory StandingsMetrics.fromWidth(double width) {
    if (width >= 1100) {
      return const StandingsMetrics(
        teamColumnWidth: 360,
        statColumnWidth: 56,
        formColumnWidth: 148,
        rankBadgeSize: 24,
        teamLogoSize: 24,
        formIndicatorSize: 18,
        formSpacing: 6,
        horizontalPadding: 10,
        verticalPadding: 10,
        headerHorizontalPadding: 12,
        headerVerticalPadding: 14,
        teamContentSpacing: 12,
      );
    }
    if (width >= 810) {
      return const StandingsMetrics(
        teamColumnWidth: 290,
        statColumnWidth: 46,
        formColumnWidth: 124,
        rankBadgeSize: 22,
        teamLogoSize: 22,
        formIndicatorSize: 16,
        formSpacing: 5,
        horizontalPadding: 8,
        verticalPadding: 8,
        headerHorizontalPadding: 10,
        headerVerticalPadding: 12,
        teamContentSpacing: 10,
      );
    }
    return const StandingsMetrics(
      teamColumnWidth: 240,
      statColumnWidth: 40,
      formColumnWidth: 104,
      rankBadgeSize: 18,
      teamLogoSize: 18,
      formIndicatorSize: 14,
      formSpacing: 4,
      horizontalPadding: 6,
      verticalPadding: 6,
      headerHorizontalPadding: 8,
      headerVerticalPadding: 10,
      teamContentSpacing: 8,
    );
  }
}
