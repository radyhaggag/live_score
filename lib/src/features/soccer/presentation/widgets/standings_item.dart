import 'package:flutter/material.dart';
import 'package:live_score/src/core/extensions/color.dart';
import 'package:live_score/src/core/extensions/strings.dart';
import 'package:live_score/src/core/l10n/app_l10n.dart';
import 'package:live_score/src/core/utils/app_colors.dart';

import '../../../../core/widgets/custom_image.dart';
import '../../domain/entities/team_rank.dart';
import 'standings_form.dart';

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
        final metrics = _StandingsMetrics.fromWidth(constraints.maxWidth);
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

        Color? rankBackground(int rank, int totalTeams) {
          if (isGrouped) return AppColors.white;
          if (rank == 1) return AppColors.green;
          if (rank == 2) return AppColors.blue;
          if (rank == 3) return AppColors.purple;
          if (rank > totalTeams - 3) return AppColors.red;
          return AppColors.white;
        }

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
                    SizedBox(
                      width: metrics.rankBadgeSize,
                      height: metrics.rankBadgeSize,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: rankBackground(teamRank.rank, totalTeams),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 3),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                teamRank.rank.toString(),
                                textAlign: TextAlign.center,
                                style: Theme.of(
                                  context,
                                ).textTheme.labelMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: rankColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
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

class StandingsHeaders extends StatelessWidget {
  const StandingsHeaders({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final metrics = _StandingsMetrics.fromWidth(constraints.maxWidth);
        final headers = [
          context.l10n.playedShort,
          context.l10n.wonShort,
          context.l10n.drawnShort,
          context.l10n.lostShort,
          context.l10n.goalsForShort,
          context.l10n.goalsAgainstShort,
          context.l10n.goalDifferenceShort,
          context.l10n.pointsShort,
        ];

        return Container(
          color: AppColors.grey.withOpacitySafe(.05),
          padding: EdgeInsets.symmetric(
            vertical: metrics.headerVerticalPadding,
            horizontal: metrics.headerHorizontalPadding,
          ),
          child: Row(
            children: [
              SizedBox(
                width: metrics.teamColumnWidth,
                child: Row(
                  spacing: metrics.teamContentSpacing,
                  children: [
                    Text('#', style: _getHeaderTextStyle(context)),
                    Text(
                      context.l10n.teamName,
                      style: _getHeaderTextStyle(context),
                    ),
                  ],
                ),
              ),
              ...List.generate(
                headers.length,
                (index) => SizedBox(
                  width: metrics.statColumnWidth,
                  child: Text(
                    headers[index],
                    textAlign: TextAlign.center,
                    style: _getHeaderTextStyle(context),
                  ),
                ),
              ),
              SizedBox(
                width: metrics.formColumnWidth,
                child: Text(
                  context.l10n.form,
                  textAlign: TextAlign.center,
                  style: _getHeaderTextStyle(context),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  TextStyle? _getHeaderTextStyle(BuildContext context) {
    return Theme.of(
      context,
    ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold);
  }
}

class _StandingsMetrics {
  const _StandingsMetrics({
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

  factory _StandingsMetrics.fromWidth(double width) {
    if (width >= 1100) {
      return const _StandingsMetrics(
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
      return const _StandingsMetrics(
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
    return const _StandingsMetrics(
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
