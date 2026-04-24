import 'package:live_score/src/core/extensions/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:live_score/src/core/constants/app_spacing.dart';
import 'package:live_score/src/core/extensions/strings.dart';

import '../../../../core/domain/entities/soccer_fixture.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../../core/l10n/app_l10n.dart';
import '../../../../core/widgets/match_time_with_progress.dart';
import 'fixture_league_section.dart';
import 'fixture_score_text.dart';
import 'fixture_status_badge.dart';
import 'fixture_team_info.dart';

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
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xs,
      ).copyWith(top: AppSpacing.m),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
        side: BorderSide(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.08),
        ),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(
          vertical: AppSpacing.l,
          horizontal: AppSpacing.m,
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final sideWidth = constraints.maxWidth >= 700 ? 150.0 : 110.0;

            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: sideWidth,
                  child: FixtureTeamInfo(
                    name: soccerFixture.teams.home.name.teamName,
                    logo: soccerFixture.teams.home.logo,
                  ),
                ),
                const SizedBox(width: AppSpacing.s),
                Expanded(
                  child: _FixtureCenter(
                    soccerFixture: soccerFixture,
                    fixtureTime: fixtureTime,
                    showLeagueLogo: showLeagueLogo,
                  ),
                ),
                const SizedBox(width: AppSpacing.s),
                SizedBox(
                  width: sideWidth,
                  child: FixtureTeamInfo(
                    name: soccerFixture.teams.away.name.teamName,
                    logo: soccerFixture.teams.away.logo,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _FixtureCenter extends StatelessWidget {
  final SoccerFixture soccerFixture;
  final String? fixtureTime;
  final bool showLeagueLogo;

  const _FixtureCenter({
    required this.soccerFixture,
    required this.fixtureTime,
    this.showLeagueLogo = true,
  });

  @override
  Widget build(BuildContext context) {
    final homeTeam = soccerFixture.teams.home;
    final awayTeam = soccerFixture.teams.away;
    final goalsAvailable = homeTeam.score != -1 && awayTeam.score != -1;

    // Scheduled or ended without goals
    if (soccerFixture.status.isScheduled ||
        (soccerFixture.status.isEnded && !goalsAvailable)) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            fixtureTime ?? context.l10n.tbd,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: context.colorsExt.deepOrange,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xs),
          _LeagueAndStatus(
            soccerFixture: soccerFixture,
            showLeagueLogo: showLeagueLogo,
            showRound: true,
          ),
        ],
      );
    }

    // Live with goals
    if (soccerFixture.status.isLive && goalsAvailable) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          MatchTimeWithProgress(time: soccerFixture.gameTimeDisplay),
          _ScoreRow(homeScore: homeTeam.score, awayScore: awayTeam.score),
          _AggregateRow(
            homeAgg: homeTeam.aggregatedScore,
            awayAgg: awayTeam.aggregatedScore,
          ),
          const SizedBox(height: AppSpacing.xs),
          _LeagueAndStatus(
            soccerFixture: soccerFixture,
            showLeagueLogo: showLeagueLogo,
          ),
        ],
      );
    }

    // Ended with goals
    if (goalsAvailable) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          _ScoreRow(homeScore: homeTeam.score, awayScore: awayTeam.score),
          _AggregateRow(
            homeAgg: homeTeam.aggregatedScore,
            awayAgg: awayTeam.aggregatedScore,
          ),
          const SizedBox(height: AppSpacing.xs),
          _LeagueAndStatus(
            soccerFixture: soccerFixture,
            showLeagueLogo: showLeagueLogo,
          ),
        ],
      );
    }

    return const SizedBox.shrink();
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

/// Shared league section + status badge footer.
class _LeagueAndStatus extends StatelessWidget {
  final SoccerFixture soccerFixture;
  final bool showLeagueLogo;
  final bool showRound;

  const _LeagueAndStatus({
    required this.soccerFixture,
    required this.showLeagueLogo,
    this.showRound = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FixtureLeagueSection(
          league: soccerFixture.fixtureLeague,
          roundNum: showRound ? soccerFixture.roundNum : null,
          showLogo: showLeagueLogo,
        ),
        const SizedBox(height: AppSpacing.xs),
        FixtureStatusBadge(
          status: soccerFixture.status,
          statusText: soccerFixture.statusText,
        ),
      ],
    );
  }
}
