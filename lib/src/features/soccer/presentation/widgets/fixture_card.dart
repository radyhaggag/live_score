import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:live_score/src/core/extensions/nums.dart';

import '../../../../core/domain/entities/soccer_fixture.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_fonts.dart';

class FixtureCard extends StatelessWidget {
  final SoccerFixture soccerFixture;
  final String? fixtureTime;

  const FixtureCard({super.key, required this.soccerFixture, this.fixtureTime});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.radius,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsetsDirectional.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _TeamInfo(
              name: soccerFixture.teams.home.name,
              logo: soccerFixture.teams.home.logo,
            ),
            Expanded(
              child: _FixtureCenter(
                soccerFixture: soccerFixture,
                fixtureTime: fixtureTime,
              ),
            ),
            _TeamInfo(
              name: soccerFixture.teams.away.name,
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
          CachedNetworkImage(
            height: 25.radius,
            width: 25.radius,
            imageUrl: logo,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
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

  const _FixtureCenter({
    required this.soccerFixture,
    required this.fixtureTime,
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
            fixtureTime ?? "TBD",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.deepOrange,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
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

    if (soccerFixture.status.isLive && goalsAvailable) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            soccerFixture.gameTimeDisplay.isNotEmpty
                ? soccerFixture.gameTimeDisplay
                : "LIVE",
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: AppColors.red,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 5.height),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _ScoreText(value: homeTeam.score.toString()),
              _ScoreText(value: ":"),
              _ScoreText(value: awayTeam.score.toString()),
            ],
          ),
          if (homeTeam.aggregatedScore != null &&
              awayTeam.aggregatedScore != null) ...[
            SizedBox(height: 5.height),
            Text(
              "Aggregate (${homeTeam.aggregatedScore} - ${awayTeam.aggregatedScore})",
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
              _ScoreText(value: ":"),
              _ScoreText(value: awayTeam.score.toString()),
            ],
          ),
          if (homeTeam.aggregatedScore != null &&
              awayTeam.aggregatedScore != null) ...[
            SizedBox(height: 5.height),
            Text(
              "Aggregate (${homeTeam.aggregatedScore} - ${awayTeam.aggregatedScore})",
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
  final FixtureLeague league;

  const _LeagueSection({required this.league});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CachedNetworkImage(
          height: 15.radius,
          width: 15.radius,
          imageUrl: league.logo,
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        SizedBox(width: 5.width),
        Text(
          league.name,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.blueGrey,
            fontSize: FontSize.paragraph,
          ),
          textAlign: TextAlign.center,
        ),
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
