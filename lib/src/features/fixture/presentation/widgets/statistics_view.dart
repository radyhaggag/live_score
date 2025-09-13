import 'package:flutter/material.dart';
import 'package:live_score/src/core/extensions/nums.dart';
import 'package:live_score/src/core/extensions/strings.dart';

import '../../../../core/domain/entities/teams.dart';
import '../../../../core/media_query.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_image.dart';
import '../../domain/entities/statistics.dart';

/// Main Statistics View
class StatisticsView extends StatelessWidget {
  final Statistics? statistics;

  const StatisticsView({super.key, this.statistics});

  @override
  Widget build(BuildContext context) {
    if (statistics?.statistics == null ||
        (statistics?.statistics ?? []).isEmpty ||
        statistics?.teams == null) {
      return const NoStatistics();
    }

    final grouped = _groupStats(
      homeStats: statistics!.homeStatistics!,
      awayStats: statistics!.awayStatistics!,
    );

    return Column(
      children: [
        StatsHeader(teams: statistics!.teams!),
        ListView.separated(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final group = grouped[index];
            return StatsCategorySection(
              isTop: group.isTop,
              categoryName: group.categoryName,
              homeStats: group.homeStats,
              awayStats: group.awayStats,
            );
          },
          separatorBuilder: (context, index) => SizedBox(height: 20.height),
          itemCount: grouped.length,
        ),
      ],
    );
  }

  /// Group stats → top first, then by category
  List<_GroupedStats> _groupStats({
    required List<Statistic> homeStats,
    required List<Statistic> awayStats,
  }) {
    final List<_GroupedStats> result = [];
    final Map<int, _GroupedStats> categoryMap = {};

    final List<Statistic> topHome = [];
    final List<Statistic> topAway = [];

    for (var i = 0; i < homeStats.length; i++) {
      final home = homeStats[i];
      final away = awayStats[i];

      if (home.isTop == true) {
        // Always add to top stats
        topHome.add(home);
        topAway.add(away);

        // If it has categoryId, also add it to its category
        if (home.categoryId != null) {
          categoryMap.putIfAbsent(
            home.categoryId!,
            () => _GroupedStats(
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
        // Normal category stat
        categoryMap.putIfAbsent(
          home.categoryId!,
          () => _GroupedStats(
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

    // Add top stats section first
    if (topHome.isNotEmpty) {
      result.add(_GroupedStats.top(homeStats: topHome, awayStats: topAway));
    }

    // Then add categories
    result.addAll(categoryMap.values);

    return result;
  }
}

/// Shows no statistics
class NoStatistics extends StatelessWidget {
  const NoStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: const AssetImage(AppAssets.noStats),
            width: 100.radius,
            height: 100.radius,
          ),
          SizedBox(height: 10.height),
          Text(
            AppStrings.noStats,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.blueGrey,
              letterSpacing: 1.1,
            ),
          ),
        ],
      ),
    );
  }
}

/// Header with teams
class StatsHeader extends StatelessWidget {
  final Teams teams;

  const StatsHeader({super.key, required this.teams});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Row(
        children: [
          Expanded(
            child: _TeamInfo(
              logo: teams.home.logo,
              name: teams.home.name,
              alignment: MainAxisAlignment.start,
            ),
          ),
          SizedBox(width: 20.width),
          Expanded(
            child: _TeamInfo(
              logo: teams.away.logo,
              name: teams.away.name,
              alignment: MainAxisAlignment.end,
            ),
          ),
        ],
      ),
    );
  }
}

/// Single team info in header
class _TeamInfo extends StatelessWidget {
  final String logo;
  final String name;
  final MainAxisAlignment alignment;

  const _TeamInfo({
    required this.logo,
    required this.name,
    required this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignment,
      children: [
        CustomImage(width: 20.radius, height: 20.radius, imageUrl: logo),
        SizedBox(width: 5.width),
        Flexible(
          child: Text(
            name.teamName,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ],
    );
  }
}

/// Category section
class StatsCategorySection extends StatelessWidget {
  final bool isTop;
  final String categoryName;
  final List<Statistic> homeStats;
  final List<Statistic> awayStats;

  const StatsCategorySection({
    super.key,
    required this.isTop,
    required this.categoryName,
    required this.homeStats,
    required this.awayStats,
  });

  @override
  Widget build(BuildContext context) {
    final title = isTop ? 'Top Stats' : categoryName;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.height),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: homeStats.length,
          separatorBuilder: (_, _) => Divider(height: 20.height),
          itemBuilder: (context, index) {
            return StatsRow(home: homeStats[index], away: awayStats[index]);
          },
        ),
      ],
    );
  }
}

/// A row comparing home vs away stat
class StatsRow extends StatelessWidget {
  final Statistic home;
  final Statistic away;

  const StatsRow({super.key, required this.home, required this.away});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(child: Text(home.value, textAlign: TextAlign.center)),
        Expanded(
          flex: 3,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              home.name,
              textAlign: TextAlign.center,
              maxLines: 1,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ),
        Expanded(child: Text(away.value, textAlign: TextAlign.center)),
      ],
    );
  }
}

/// Private model for grouped stats
class _GroupedStats {
  final bool isTop;
  final int? categoryId;
  final String categoryName;
  final List<Statistic> homeStats;
  final List<Statistic> awayStats;

  _GroupedStats({
    required this.isTop,
    this.categoryId,
    required this.categoryName,
    required this.homeStats,
    required this.awayStats,
  });

  factory _GroupedStats.top({
    required List<Statistic> homeStats,
    required List<Statistic> awayStats,
  }) {
    return _GroupedStats(
      isTop: true,
      categoryId: null,
      categoryName: 'Top Stats',
      homeStats: homeStats,
      awayStats: awayStats,
    );
  }
}
