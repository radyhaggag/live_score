import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:live_score/src/core/constants/app_spacing.dart';

import '../../../../core/extensions/context_ext.dart';
import '../../../../core/l10n/app_l10n.dart';
import '../../domain/entities/statistics.dart';
import 'stats_row.dart';

/// A section of statistics grouped by category.
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
    final title = isTop ? context.l10n.topStats : categoryName;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.analytics_outlined,
                  size: 20,
                  color: context.colorsExt.blue,
                ),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Container(
              height: 3,
              width: 40,
              decoration: BoxDecoration(
                gradient: context.colorsExt.liveGradient,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.m),
        Column(
          children: List.generate(homeStats.length, (index) {
            return Column(
              children: [
                StatsRow(home: homeStats[index], away: awayStats[index])
                    .animate()
                    .fade(duration: 300.ms, delay: (50 * index).ms)
                    .slideY(begin: 0.1),
                if (index < homeStats.length - 1)
                  const SizedBox(height: AppSpacing.l),
              ],
            );
          }),
        ),
      ],
    );
  }
}
