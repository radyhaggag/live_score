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

        final Color rankColor =
            isGrouped
                ? Colors.black
                : (teamRank.rank <= 3 || teamRank.rank > totalTeams - 3)
                ? Colors.white
                : Colors.black;

        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: metrics.verticalPadding,
            horizontal: metrics.horizontalPadding,
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
                      totalTeams: totalTeams,
                      isGrouped: isGrouped,
                      rankColor: rankColor,
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
                        style: Theme.of(context).textTheme.titleSmall,
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
                    style: Theme.of(context).textTheme.titleSmall,
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
    required this.totalTeams,
    required this.isGrouped,
    required this.rankColor,
    required this.size,
  });

  final int rank;
  final int totalTeams;
  final bool isGrouped;
  final Color rankColor;
  final double size;

  @override
  Widget build(BuildContext context) {
    Color? background() {
      if (isGrouped) return context.colorsExt.white;
      if (rank == 1) return context.colorsExt.green;
      if (rank == 2) return context.colorsExt.blue;
      if (rank == 3) return context.colorsExt.purple;
      if (rank > totalTeams - 3) return context.colorsExt.red;
      return context.colorsExt.white;
    }

    return SizedBox(
      width: size,
      height: size,
      child: DecoratedBox(
        decoration: BoxDecoration(color: background(), shape: BoxShape.circle),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                rank.toString(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: rankColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
