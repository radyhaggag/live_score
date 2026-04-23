import 'package:flutter/material.dart';

import '../../../../core/l10n/app_l10n.dart';
import '../../domain/entities/statistics.dart';
import 'stats_row.dart';
import 'package:live_score/src/core/constants/app_spacing.dart';

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
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: AppSpacing.s),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: homeStats.length,
          separatorBuilder: (_, _) => const Divider(height: 20),
          itemBuilder: (context, index) {
            return StatsRow(home: homeStats[index], away: awayStats[index]);
          },
        ),
      ],
    );
  }
}
