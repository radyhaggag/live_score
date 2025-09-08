import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:live_score/src/core/extensions/color.dart';
import 'package:live_score/src/core/extensions/nums.dart';

import '../../../../core/domain/entities/soccer_fixture.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../soccer/presentation/screens/soccer_screen.dart';
import 'view_team.dart';

class FixtureDetails extends StatelessWidget {
  final SoccerFixture soccerFixture;

  const FixtureDetails({super.key, required this.soccerFixture});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(gradient: getGradientColor(soccerFixture)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CachedNetworkImage(
                fit: BoxFit.cover,
                width: 20.radius,
                height: 20.radius,
                imageUrl: soccerFixture.fixtureLeague.logo,
              ),
              SizedBox(width: 5.width),
              Text(
                soccerFixture.fixtureLeague.name,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: AppColors.white),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          SizedBox(height: 10.height),
          Row(
            children: [
              Expanded(child: ViewTeam(team: soccerFixture.teams.home)),
              (soccerFixture.fixture.status.elapsed != null)
                  ? Expanded(child: buildFixtureResult(context))
                  : Expanded(child: buildFixtureTime(context)),
              Expanded(child: ViewTeam(team: soccerFixture.teams.away)),
            ],
          ),
          SizedBox(height: 10.height),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              color: AppColors.lightRed,
              borderRadius: BorderRadius.circular(20.radius),
            ),
            child: Text(
              soccerFixture.fixture.status.long,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFixtureResult(BuildContext context) {
    TextStyle? displaySmall = Theme.of(
      context,
    ).textTheme.displaySmall?.copyWith(color: AppColors.white);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(soccerFixture.goals.home.toString(), style: displaySmall),
            SizedBox(width: 10.width),
            Text(":", style: displaySmall),
            SizedBox(width: 10.width),
            Text(soccerFixture.goals.away.toString(), style: displaySmall),
          ],
        ),
        SizedBox(height: 5.height),
        buildFixtureRound(context),
      ],
    );
  }

  Widget buildFixtureTime(BuildContext context) {
    String fixtureTime = soccerFixture.fixture.date;
    final localTime = DateTime.parse(fixtureTime).toLocal();
    final formattedTime = DateFormat("h:mm a").format(localTime);
    return Column(
      children: [
        Text(
          formattedTime,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(color: AppColors.white),
        ),
        SizedBox(height: 5.height),
        buildFixtureRound(context),
      ],
    );
  }

  Widget buildFixtureRound(BuildContext context) => Text(
    soccerFixture.fixtureLeague.round,
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    style: Theme.of(context).textTheme.bodySmall?.copyWith(
      color: AppColors.white.withOpacitySafe(0.9),
    ),
  );
}
