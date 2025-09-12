import 'package:flutter/material.dart';
import 'package:live_score/src/core/domain/entities/league.dart';
import 'package:live_score/src/core/extensions/nums.dart';
import 'package:live_score/src/core/extensions/strings.dart';

import '../../../../core/domain/entities/soccer_fixture.dart';
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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4).copyWith(top: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          const BoxShadow(
            color: AppColors.lightGrey,
            spreadRadius: 2,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(
          vertical: 15,
          horizontal: 10,
        ),
        child: Row(
          children: [
            _TeamInfo(
              name: soccerFixture.teams.home.name.teamName,
              logo: soccerFixture.teams.home.logo,
            ),
            SizedBox(width: 5.width),
            Expanded(
              child: _FixtureCenter(
                soccerFixture: soccerFixture,
                fixtureTime: fixtureTime,
                showLeagueLogo: showLeagueLogo,
              ),
            ),
            SizedBox(width: 5.width),
            _TeamInfo(
              name: soccerFixture.teams.away.name.teamName,
              logo: soccerFixture.teams.away.logo,
            ),
          ],
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
    return Expanded(
      child: Column(
        children: [
          CustomImage(height: 25.radius, width: 25.radius, imageUrl: logo),
          SizedBox(height: 10.height),
          FittedBox(
            child: Text(
              name.split(' ').length > 2
                  ? name.split(' ').sublist(0, 2).join(' ')
                  : name,
              textAlign: TextAlign.center,
              overflow: TextOverflow.fade,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.black),
            ),
          ),
        ],
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

    if (soccerFixture.status.isScheduled ||
        (soccerFixture.status.isEnded && !goalsAvailable)) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            fixtureTime ?? 'TBD',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.deepOrange,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 5.height),
          _LeagueSection(
            league: soccerFixture.fixtureLeague,
            roundNum: soccerFixture.roundNum,
            showLogo: showLeagueLogo,
          ),
          SizedBox(height: 5.height),
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
        children: [
          MatchTimeWithProgress(
            time:
                soccerFixture.gameTimeDisplay.isNotEmpty
                    ? soccerFixture.gameTimeDisplay
                    : 'LIVE',
          ),
          SizedBox(height: 5.height),
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
            SizedBox(height: 5.height),
            Text(
              'Aggregate (${homeTeam.aggregatedScore} - ${awayTeam.aggregatedScore})',
              style: Theme.of(
                context,
              ).textTheme.labelSmall?.copyWith(color: AppColors.blueGrey),
              textAlign: TextAlign.center,
            ),
          ],
          SizedBox(height: 5.height),
          _LeagueSection(league: soccerFixture.fixtureLeague),
          SizedBox(height: 5.height),
          _StatusBadge(
            status: soccerFixture.status,
            statusText: soccerFixture.statusText,
          ),
        ],
      );
    }

    if (goalsAvailable) {
      // Ended match
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
            SizedBox(height: 5.height),
            Text(
              'Aggregate (${homeTeam.aggregatedScore} - ${awayTeam.aggregatedScore})',
              style: Theme.of(
                context,
              ).textTheme.labelSmall?.copyWith(color: AppColors.blueGrey),
              textAlign: TextAlign.center,
            ),
          ],
          SizedBox(height: 5.height),
          _LeagueSection(league: soccerFixture.fixtureLeague),
          SizedBox(height: 5.height),
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
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showLogo) ...[
              CustomImage(
                height: 13.radius,
                width: 13.radius,
                imageUrl: league.logo,
              ),
              SizedBox(width: 5.width),
            ],
            Flexible(
              child: FittedBox(
                child: Text(
                  league.name,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(color: AppColors.blueGrey),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
        if (roundNum != null) ...[
          SizedBox(height: 3.height),
          Text(
            'Round ${roundNum.toString()}',
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
        borderRadius: BorderRadius.circular(20.radius),
      ),
      child: FittedBox(
        child: Text(
          statusText,
          maxLines: 1,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.white,
            fontSize: FontSize.paragraph,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
