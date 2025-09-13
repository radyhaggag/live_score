import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:live_score/src/core/extensions/color.dart';
import 'package:live_score/src/core/extensions/fixture.dart';
import 'package:live_score/src/core/extensions/nums.dart';
import 'package:live_score/src/core/widgets/match_time_with_progress.dart';

import '../../../../core/domain/entities/soccer_fixture.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_image.dart';
import 'view_team.dart';

class FixtureDetails extends StatelessWidget {
  final SoccerFixture soccerFixture;

  const FixtureDetails({super.key, required this.soccerFixture});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      decoration: BoxDecoration(gradient: soccerFixture.gradientColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomImage(
                fit: BoxFit.cover,
                width: 20.radius,
                height: 20.radius,
                imageUrl: soccerFixture.fixtureLeague.logo,
              ),
              SizedBox(width: 5.width),
              Flexible(
                child: FittedBox(
                  child: Text(
                    soccerFixture.fixtureLeague.name,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: AppColors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.height),
          Row(
            children: [
              Expanded(child: ViewTeam(team: soccerFixture.teams.home)),
              (soccerFixture.gameTime != null && soccerFixture.gameTime! > 0)
                  ? Expanded(child: buildFixtureResult(context))
                  : Expanded(child: buildFixtureTime(context)),
              Expanded(child: ViewTeam(team: soccerFixture.teams.away)),
            ],
          ),
          SizedBox(height: 10.height),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            decoration: BoxDecoration(
              color:
                  soccerFixture.isThereWinner
                      ? AppColors.lightRed
                      : AppColors.darkBlue,
              borderRadius: BorderRadius.circular(20.radius),
            ),
            child: Text(
              soccerFixture.statusText,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.white),
            ),
          ),
          if (soccerFixture.status.isLive) ...[
            SizedBox(height: 10.height),
            MatchTimeWithProgress(
              time: soccerFixture.gameTimeDisplay,
              mainColor: AppColors.white,
              widthFactor: 4,
            ),
          ],
        ],
      ),
    );
  }

  Widget buildFixtureResult(BuildContext context) {
    final TextStyle? displaySmall = Theme.of(
      context,
    ).textTheme.displaySmall?.copyWith(color: AppColors.white);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              soccerFixture.teams.home.score.toString(),
              style: displaySmall,
            ),
            SizedBox(width: 10.width),
            Text(':', style: displaySmall),
            SizedBox(width: 10.width),
            Text(
              soccerFixture.teams.away.score.toString(),
              style: displaySmall,
            ),
          ],
        ),
        SizedBox(height: 5.height),
        buildFixtureRound(context),
      ],
    );
  }

  Widget buildFixtureTime(BuildContext context) {
    final String fixtureTime = soccerFixture.startTime.toString();
    final localTime = DateTime.parse(fixtureTime).toLocal();
    final formattedTime = DateFormat('h:mm a').format(localTime);
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
    soccerFixture.roundNum != null
        ? 'Round ${soccerFixture.roundNum}'
        : 'Season ${soccerFixture.seasonNum}',
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    style: Theme.of(context).textTheme.bodySmall?.copyWith(
      color: AppColors.white.withOpacitySafe(0.9),
    ),
  );
}
