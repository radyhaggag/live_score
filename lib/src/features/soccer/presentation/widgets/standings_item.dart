import 'package:flutter/material.dart';
import 'package:live_score/src/core/extensions/strings.dart';
import 'package:live_score/src/core/extensions/context_ext.dart';

import '../../../../core/widgets/custom_image.dart';
import '../../domain/entities/team_rank.dart';
import 'standings_form.dart';
import 'standings_metrics.dart';

/// A single row in the standings table showing a team's rank and stats.
class StandingsItem extends StatelessWidget {
  final TeamRank teamRank;
  final int totalTeams;
  final bool isGrouped;

  const StandingsItem({
    super.key,
    required this.teamRank,
    required this.totalTeams,
    this.isGrouped = false,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final metrics = StandingsMetrics.fromWidth(constraints.maxWidth);
        final headersNumbers = [
          '${teamRank.stats.played}',
          '${teamRank.stats.win}',
          '${teamRank.stats.draw}',
          '${teamRank.stats.lose}',
          '${teamRank.stats.scored}',
          '${teamRank.stats.received}',
          '${teamRank.goalsDiff}',
          '${teamRank.points}',
        ];



        return Container(
          padding: EdgeInsets.symmetric(
            vertical: metrics.verticalPadding,
            horizontal: metrics.horizontalPadding,
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.05),
              ),
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                width: metrics.teamColumnWidth,
                child: Row(
                  spacing: metrics.teamContentSpacing,
                  children: [
                    _RankBadge(
                      rank: teamRank.rank,
                      teamRank: teamRank,
                      totalTeams: totalTeams,
                      isGrouped: isGrouped,
                      size: metrics.rankBadgeSize,
                    ),
                    CustomImage(
                      width: metrics.teamLogoSize,
                      height: metrics.teamLogoSize,
                      imageUrl: teamRank.team.logo,
                    ),
                    Expanded(
                      child: Text(
                        teamRank.team.name.teamName,
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              ...List.generate(
                headersNumbers.length,
                (index) => SizedBox(
                  width: metrics.statColumnWidth,
                  child: Text(
                    headersNumbers[index],
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
              SizedBox(
                width: metrics.formColumnWidth,
                child: StandingsForm(
                  form: teamRank.form,
                  itemSize: metrics.formIndicatorSize,
                  spacing: metrics.formSpacing,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _RankBadge extends StatelessWidget {
  const _RankBadge({
    required this.rank,
    required this.teamRank,
    required this.totalTeams,
    required this.isGrouped,
    required this.size,
  });

  final int rank;
  final TeamRank teamRank;
  final int totalTeams;
  final bool isGrouped;
  final double size;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Color? background() {
      if (isGrouped) return context.colorsExt.white;
      // Default to transparent/white if no destination
      if (teamRank.destinationNum == null) return Colors.transparent;

      switch (teamRank.destinationNum) {
        case 1:
          return context.colorsExt.blue;
        case 2:
          return context.colorsExt.deepOrange;
        case 3:
          return context.colorsExt.green;
        case 4:
          return context.colorsExt.red;
        case 5:
          return context.colorsExt.purple;
        default:
          return Colors.transparent;
      }
    }

    final bgColor = background();
    final bool isTransparent = bgColor == Colors.transparent || bgColor == context.colorsExt.white;
    final rColor = isTransparent ? theme.colorScheme.onSurface : Colors.white;

    return SizedBox(
      width: size,
      height: size,
      child: DecoratedBox(
        decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                rank.toString(),
                textAlign: TextAlign.center,
                style: theme.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: rColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
