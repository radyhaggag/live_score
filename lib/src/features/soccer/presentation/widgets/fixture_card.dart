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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
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
            fit: BoxFit.cover,
            height: 45.radius,
            width: 45.radius,
            imageUrl: logo,
          ),
          SizedBox(height: 10.height),
          Text(
            name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.fade,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeights.medium,
              fontSize: FontSize.details,
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
    final isNotStarted = soccerFixture.fixture.status.short == "NS";
    final goalsAvailable =
        soccerFixture.goals.home != null && soccerFixture.goals.away != null;

    if (isNotStarted) {
      return Column(
        children: [
          Text(
            fixtureTime ?? "",
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: AppColors.deepOrange),
          ),
          SizedBox(height: 5.height),
          _LeagueName(name: soccerFixture.fixtureLeague.name),
        ],
      );
    }

    if (goalsAvailable) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _ScoreText(value: soccerFixture.goals.home.toString()),
              _ScoreText(value: ":"),
              _ScoreText(value: soccerFixture.goals.away.toString()),
            ],
          ),
          SizedBox(height: 5.height),
          _LeagueName(name: soccerFixture.fixtureLeague.name),
          SizedBox(height: 5.height),
          if (soccerFixture.fixture.status.elapsed != null)
            _StatusBadge(status: soccerFixture.fixture.status.short),
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
      style: Theme.of(
        context,
      ).textTheme.titleLarge?.copyWith(color: AppColors.deepOrange),
    );
  }
}

class _LeagueName extends StatelessWidget {
  final String name;
  const _LeagueName({required this.name});

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: AppColors.blueGrey,
        fontSize: FontSize.paragraph,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final isLive = status != "FT";
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: isLive ? AppColors.red : AppColors.blue,
        borderRadius: BorderRadius.circular(20.radius),
      ),
      child: Text(
        isLive ? "Live" : "End",
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: AppColors.white,
          fontSize: FontSize.paragraph,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
