import 'package:flutter/material.dart';

import '../../domain/entities/statistics.dart';
import 'grouped_stats_model.dart';
import 'no_statistics.dart';
import 'stats_category_section.dart';
import 'stats_header.dart';
import 'package:live_score/src/core/constants/app_spacing.dart';

/// Main Statistics View — displays grouped match statistics.
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

    final grouped = groupStats(
      homeStats: statistics!.homeStatistics!,
      awayStats: statistics!.awayStatistics!,
    );

    return Column(
      children: [
        StatsHeader(teams: statistics!.teams!),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(AppSpacing.xl),
          itemBuilder: (context, index) {
            final group = grouped[index];
            return StatsCategorySection(
              isTop: group.isTop,
              categoryName: group.categoryName,
              homeStats: group.homeStats,
              awayStats: group.awayStats,
            );
          },
          separatorBuilder:
              (context, index) => const SizedBox(height: AppSpacing.xl),
          itemCount: grouped.length,
        ),
      ],
    );
  }
}
