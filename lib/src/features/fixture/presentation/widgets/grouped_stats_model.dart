import '../../domain/entities/statistics.dart';

/// Private model for grouping statistics by category.
class GroupedStats {
  final bool isTop;
  final int? categoryId;
  final String categoryName;
  final List<Statistic> homeStats;
  final List<Statistic> awayStats;

  GroupedStats({
    required this.isTop,
    this.categoryId,
    required this.categoryName,
    required this.homeStats,
    required this.awayStats,
  });

  factory GroupedStats.top({
    required List<Statistic> homeStats,
    required List<Statistic> awayStats,
  }) {
    return GroupedStats(
      isTop: true,
      categoryId: null,
      categoryName: '',
      homeStats: homeStats,
      awayStats: awayStats,
    );
  }
}

/// Groups statistics into top stats and categorized stats.
List<GroupedStats> groupStats({
  required List<Statistic> homeStats,
  required List<Statistic> awayStats,
}) {
  final List<GroupedStats> result = [];
  final Map<int, GroupedStats> categoryMap = {};

  final List<Statistic> topHome = [];
  final List<Statistic> topAway = [];

  for (var i = 0; i < homeStats.length; i++) {
    final home = homeStats[i];
    final away = awayStats[i];

    if (home.isTop == true) {
      topHome.add(home);
      topAway.add(away);

      if (home.categoryId != null) {
        categoryMap.putIfAbsent(
          home.categoryId!,
          () => GroupedStats(
            isTop: false,
            categoryId: home.categoryId!,
            categoryName: home.categoryName ?? '',
            homeStats: [],
            awayStats: [],
          ),
        );
        categoryMap[home.categoryId]!.homeStats.add(home);
        categoryMap[home.categoryId]!.awayStats.add(away);
      }
    } else if (home.categoryId != null) {
      categoryMap.putIfAbsent(
        home.categoryId!,
        () => GroupedStats(
          isTop: false,
          categoryId: home.categoryId!,
          categoryName: home.categoryName ?? '',
          homeStats: [],
          awayStats: [],
        ),
      );
      categoryMap[home.categoryId]!.homeStats.add(home);
      categoryMap[home.categoryId]!.awayStats.add(away);
    }
  }

  if (topHome.isNotEmpty) {
    result.add(GroupedStats.top(homeStats: topHome, awayStats: topAway));
  }

  result.addAll(categoryMap.values);

  return result;
}
