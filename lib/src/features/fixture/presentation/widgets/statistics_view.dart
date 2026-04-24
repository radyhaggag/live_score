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
        Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            children: List.generate(grouped.length, (index) {
              final group = grouped[index];
              return Column(
                children: [
                  StatsCategorySection(
                    isTop: group.isTop,
                    categoryName: group.categoryName,
                    homeStats: group.homeStats,
                    awayStats: group.awayStats,
                  ),
                  if (index < grouped.length - 1)
                    const SizedBox(height: AppSpacing.xl),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }
}
