import 'package:flutter/material.dart';
import 'package:live_score/src/core/domain/entities/league.dart';
import 'package:live_score/src/core/extensions/strings.dart';

import '../../../../core/domain/entities/soccer_fixture.dart';
import '../../../../core/l10n/app_l10n.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/widgets/custom_image.dart';
import '../../../../core/widgets/match_time_with_progress.dart';
import '../../../fixture/domain/enums.dart';

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
    final isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4).copyWith(top: 10),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(10),
        border:
            isDarkMode
                ? Border.all(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.08),
                )
                : null,
        boxShadow: [
          BoxShadow(
            color:
                isDarkMode
                    ? Colors.black.withValues(alpha: 0.18)
                    : AppColors.lightGrey,
            spreadRadius: 2,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(
          vertical: 15,
          horizontal: 10,
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final sideWidth = constraints.maxWidth >= 700 ? 150.0 : 110.0;

            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: sideWidth,
                  child: _TeamInfo(
                    name: soccerFixture.teams.home.name.teamName,
                    logo: soccerFixture.teams.home.logo,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _FixtureCenter(
                    soccerFixture: soccerFixture,
                    fixtureTime: fixtureTime,
                    showLeagueLogo: showLeagueLogo,
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: sideWidth,
                  child: _TeamInfo(
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

class _TeamInfo extends StatelessWidget {
  final String logo;
  final String name;

  const _TeamInfo({required this.logo, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomImage(height: 25, width: 25, imageUrl: logo),
        const SizedBox(height: 10),
        Text(
          name.split(' ').length > 2
              ? name.split(' ').sublist(0, 2).join(' ')
              : name,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
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

    if (soccerFixture.status.isScheduled ||
        (soccerFixture.status.isEnded && !goalsAvailable)) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            fixtureTime ?? context.l10n.tbd,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.deepOrange,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          _LeagueSection(
            league: soccerFixture.fixtureLeague,
            roundNum: soccerFixture.roundNum,
            showLogo: showLeagueLogo,
          ),
          const SizedBox(height: 5),
          _StatusBadge(
            status: soccerFixture.status,
            statusText: soccerFixture.statusText,
          ),
        ],
      );
    }

    if (soccerFixture.status.isLive && goalsAvailable) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          MatchTimeWithProgress(time: soccerFixture.gameTimeDisplay),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _ScoreText(value: homeTeam.score.toString()),
              const _ScoreText(value: ':'),
              _ScoreText(value: awayTeam.score.toString()),
            ],
          ),
          if (homeTeam.aggregatedScore != null &&
              awayTeam.aggregatedScore != null) ...[
            const SizedBox(height: 5),
            Text(
              context.l10n.aggregateScore(
                homeTeam.aggregatedScore.toString(),
                awayTeam.aggregatedScore.toString(),
              ),
              style: Theme.of(
                context,
              ).textTheme.labelSmall?.copyWith(color: AppColors.blueGrey),
              textAlign: TextAlign.center,
            ),
          ],
          const SizedBox(height: 5),
          _LeagueSection(league: soccerFixture.fixtureLeague),
          const SizedBox(height: 5),
          _StatusBadge(
            status: soccerFixture.status,
            statusText: soccerFixture.statusText,
          ),
        ],
      );
    }

    if (goalsAvailable) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _ScoreText(value: homeTeam.score.toString()),
              const _ScoreText(value: ':'),
              _ScoreText(value: awayTeam.score.toString()),
            ],
          ),
          if (homeTeam.aggregatedScore != null &&
              awayTeam.aggregatedScore != null) ...[
            const SizedBox(height: 5),
            Text(
              context.l10n.aggregateScore(
                homeTeam.aggregatedScore.toString(),
                awayTeam.aggregatedScore.toString(),
              ),
              style: Theme.of(
                context,
              ).textTheme.labelSmall?.copyWith(color: AppColors.blueGrey),
              textAlign: TextAlign.center,
            ),
          ],
          const SizedBox(height: 5),
          _LeagueSection(league: soccerFixture.fixtureLeague),
          const SizedBox(height: 5),
          _StatusBadge(
            status: soccerFixture.status,
            statusText: soccerFixture.statusText,
          ),
        ],
      );
    }

    return const SizedBox.shrink();
  }
}

class _ScoreText extends StatelessWidget {
  final String value;
  const _ScoreText({required this.value});

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        color: AppColors.deepOrange,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class _LeagueSection extends StatelessWidget {
  final League league;
  final int? roundNum;
  final bool showLogo;

  const _LeagueSection({
    required this.league,
    this.roundNum,
    this.showLogo = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showLogo) ...[
              CustomImage(height: 13, width: 13, imageUrl: league.logo),
              const SizedBox(width: 5),
            ],
            Flexible(
              child: Text(
                league.name,
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(color: AppColors.blueGrey),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        if (roundNum != null) ...[
          const SizedBox(height: 3),
          Text(
            context.l10n.roundNumber(roundNum.toString()),
            style: Theme.of(
              context,
            ).textTheme.labelSmall?.copyWith(color: AppColors.blueGrey),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final SoccerFixtureStatus status;
  final String statusText;

  const _StatusBadge({required this.status, required this.statusText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        color: switch (status) {
          SoccerFixtureStatus.live => AppColors.red,
          SoccerFixtureStatus.ended => AppColors.blue,
          SoccerFixtureStatus.scheduled => AppColors.blue,
        },
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        statusText,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: AppColors.white,
          fontSize: FontSize.paragraph,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
