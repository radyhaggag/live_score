import 'package:live_score/src/core/extensions/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:live_score/src/core/constants/app_spacing.dart';
import 'package:live_score/src/core/extensions/strings.dart';

import '../../../../core/domain/entities/soccer_fixture.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../../core/l10n/app_l10n.dart';
import '../../../../core/widgets/match_time_with_progress.dart';
import '../../../../core/widgets/custom_image.dart';
import 'fixture_league_section.dart';
import 'fixture_score_text.dart';
import 'fixture_status_badge.dart';
class FixtureCard extends StatelessWidget {
  final SoccerFixture soccerFixture;
  final String? fixtureTime;
  final bool showLeagueLogo;

  const FixtureCard({
    super.key,
    required this.soccerFixture,
    this.fixtureTime,
    this.showLeagueLogo = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final homeTeam = soccerFixture.teams.home;
    final awayTeam = soccerFixture.teams.away;
    final isLive = soccerFixture.status.isLive;
    final goalsAvailable = homeTeam.score != -1 && awayTeam.score != -1;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s,
      ).copyWith(top: AppSpacing.m),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.m),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // TOP HEADER: League Name, Round, Status, Time
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: FixtureLeagueSection(
                    league: soccerFixture.fixtureLeague,
                    roundNum: soccerFixture.roundNum,
                    showLogo: showLeagueLogo,
                  ),
                ),
                const SizedBox(width: AppSpacing.s),
                if (isLive)
                  MatchTimeWithProgress(time: soccerFixture.gameTimeDisplay)
                else
                  FixtureStatusBadge(
                    status: soccerFixture.status,
                    statusText: soccerFixture.statusText,
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.l),

            // MIDDLE: Teams and Score
            Row(
              children: [
                // Home Team
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Hero(
                        tag: 'team_${homeTeam.id}_fixture_${soccerFixture.id}',
                        child: CustomImage(
                          height: 32,
                          width: 32,
                          imageUrl: homeTeam.logo,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.s),
                      Flexible(
                        child: Text(
                          homeTeam.name.teamName,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Score or Time
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
                  child: Column(
                    children: [
                      if (goalsAvailable)
                        _ScoreRow(
                          homeScore: homeTeam.score,
                          awayScore: awayTeam.score,
                        )
                      else
                        Text(
                          fixtureTime ?? context.l10n.tbd,
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: context.colorsExt.deepOrange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      if (homeTeam.aggregatedScore != null &&
                          awayTeam.aggregatedScore != null)
                        _AggregateRow(
                          homeAgg: homeTeam.aggregatedScore,
                          awayAgg: awayTeam.aggregatedScore,
                        ),
                    ],
                  ),
                ),

                // Away Team
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Text(
                          awayTeam.name.teamName,
                          textAlign: TextAlign.end,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.s),
                      Hero(
                        tag: 'team_${awayTeam.id}_fixture_${soccerFixture.id}',
                        child: CustomImage(
                          height: 32,
                          width: 32,
                          imageUrl: awayTeam.logo,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Shared score row used by both live and ended states.
class _ScoreRow extends StatelessWidget {
  final int homeScore;
  final int awayScore;

  const _ScoreRow({required this.homeScore, required this.awayScore});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FixtureScoreText(value: homeScore.toString()),
        const FixtureScoreText(value: ':'),
        FixtureScoreText(value: awayScore.toString()),
      ],
    );
  }
}

/// Shared aggregate score row, returns empty if no aggregated scores.
class _AggregateRow extends StatelessWidget {
  final int? homeAgg;
  final int? awayAgg;

  const _AggregateRow({this.homeAgg, this.awayAgg});

  @override
  Widget build(BuildContext context) {
    if (homeAgg == null || awayAgg == null) return const SizedBox.shrink();
    return Column(
      children: [
        const SizedBox(height: AppSpacing.xs),
        Text(
          context.l10n.aggregateScore(homeAgg.toString(), awayAgg.toString()),
          style: Theme.of(
            context,
          ).textTheme.labelSmall?.copyWith(color: context.colorsExt.blueGrey),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

