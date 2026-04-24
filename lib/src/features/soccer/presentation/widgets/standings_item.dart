import 'package:flutter/material.dart';
import 'package:live_score/src/core/extensions/color.dart';
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
  final int index;

  const StandingsItem({
    super.key,
    required this.teamRank,
    required this.totalTeams,
    this.isGrouped = false,
    this.index = 0,
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

        final isEven = index.isEven;
        final isLeader = teamRank.rank == 1;

        return Material(
          color: isEven
              ? context.colorsExt.surfaceGlass.withOpacitySafe(0.3)
              : Colors.transparent,
          child: InkWell(
            onTap: () {}, // For hover effect
            hoverColor: context.colorsExt.surfaceGlass,
            child: Container(
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
                            teamRank.team.displayName,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: isLeader ? FontWeight.bold : null,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ...List.generate(
                    headersNumbers.length,
                    (colIndex) {
                      final isPoints = colIndex == headersNumbers.length - 1;
                      return SizedBox(
                        width: metrics.statColumnWidth,
                        child: Text(
                          headersNumbers[colIndex],
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: isPoints ? FontWeight.bold : null,
                            color: isPoints && isLeader ? context.colors.primary : null,
                          ),
                        ),
                      );
                    },
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
            ),
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

    Color? backgroundColor() {
      if (isGrouped) return context.colorsExt.white;
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

    final bgColor = backgroundColor();
    final bool isTransparent = bgColor == Colors.transparent || bgColor == context.colorsExt.white;
    final rColor = isTransparent ? theme.colorScheme.onSurface : Colors.white;

    // Use gradient for top 4 if not grouped
    final isTop4 = !isGrouped && teamRank.destinationNum != null && teamRank.destinationNum! <= 4;
    final decoration = isTop4 && bgColor != null
        ? BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [bgColor, bgColor.withOpacitySafe(0.7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: bgColor.withOpacitySafe(0.4),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          )
        : BoxDecoration(color: bgColor, shape: BoxShape.circle);

    return SizedBox(
      width: size,
      height: size,
      child: DecoratedBox(
        decoration: decoration,
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
