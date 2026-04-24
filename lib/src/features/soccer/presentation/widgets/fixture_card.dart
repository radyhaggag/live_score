import 'package:flutter/material.dart';
import 'package:live_score/src/core/constants/app_spacing.dart';
import 'package:live_score/src/core/extensions/strings.dart';
import 'package:live_score/src/core/constants/app_decorations.dart';

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
        color: context.colorsExt.surfaceElevated,
        borderRadius: AppBorderRadius.cardAll,
        border: Border.all(color: context.colorsExt.dividerSubtle),
        boxShadow: const [AppShadows.floatingShadow],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.l),
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
                  MatchTimeWithProgress(
                    time: soccerFixture.gameTimeDisplay,
                    compact: true,
                    mainColor: context.colorsExt.red,
                  )
                else
                  FixtureStatusBadge(
                    status: soccerFixture.status,
                    statusText: soccerFixture.statusText,
                  ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: AppSpacing.m),
              child: Divider(height: 1),
            ),

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
                      const SizedBox(width: AppSpacing.m),
                      Flexible(
                        child: Text(
                          homeTeam.name.teamName,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: theme.textTheme.bodySmall?.copyWith(
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
                          isLive: isLive,
                        )
                      else
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: context.colorsExt.surfaceGlass,
                            borderRadius: AppBorderRadius.smallAll,
                          ),
                          child: Text(
                            fixtureTime ?? context.l10n.tbd,
                            style: theme.textTheme.titleSmall?.copyWith(
                              color: context.colors.primary,
                              fontWeight: FontWeight.w700,
                            ),
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
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.m),
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
  final bool isLive;

  const _ScoreRow({
    required this.homeScore, 
    required this.awayScore,
    this.isLive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FixtureScoreText(
          value: homeScore.toString(),
          color: isLive ? context.colorsExt.red : null,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            ':',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: context.colorsExt.textMuted,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        FixtureScoreText(
          value: awayScore.toString(),
          color: isLive ? context.colorsExt.red : null,
        ),
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
          ).textTheme.labelSmall?.copyWith(
            color: context.colorsExt.textMuted,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
