import 'package:flutter/material.dart';
import 'package:live_score/src/core/extensions/fixture.dart';
import 'package:live_score/src/core/extensions/nums.dart';
import 'package:live_score/src/core/extensions/strings.dart';

import '../../../../core/domain/entities/soccer_fixture.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_image.dart';

class LiveFixtureCard extends StatelessWidget {
  final SoccerFixture soccerFixture;

  const LiveFixtureCard({super.key, required this.soccerFixture});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      width: 180.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.radius),
        gradient: soccerFixture.gradientColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: CustomImage(
                  height: 30.radius,
                  width: 30.radius,
                  imageUrl: soccerFixture.fixtureLeague.logo,
                ),
              ),
              Flexible(
                child: Text(
                  soccerFixture.fixtureLeague.name,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  softWrap: true,
                ),
              ),
            ],
          ),
          SizedBox(height: 15.height),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildTeamLogo(soccerFixture.teams.home.logo),
              _buildTeamLogo(soccerFixture.teams.away.logo),
            ],
          ),
          SizedBox(height: 15.height),
          _buildTeamTile(
            context: context,
            name: soccerFixture.teams.home.name.teamName,
            goals: soccerFixture.teams.home.score.toString(),
          ),
          SizedBox(height: 5.height),
          _buildTeamTile(
            context: context,
            name: soccerFixture.teams.away.name.teamName,
            goals: soccerFixture.teams.away.score.toString(),
          ),
          SizedBox(height: 10.height),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20.radius),
            ),
            child: Text(
              soccerFixture.gameTimeDisplay,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppColors.red,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 10.height),
          // Status badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20.radius),
            ),
            child: Text(
              soccerFixture.statusText,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.red,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamLogo(String logo) => CircleAvatar(
    backgroundColor: AppColors.white,
    radius: 15.radius,
    child: CustomImage(
      fit: BoxFit.cover,
      width: 25.radius,
      height: 25.radius,
      imageUrl: logo,
    ),
  );

  Widget _buildTeamTile({
    required String name,
    required String goals,
    required BuildContext context,
  }) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: Text(
          name,
          softWrap: false,
          overflow: TextOverflow.fade,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: AppColors.white),
        ),
      ),
      SizedBox(width: 10.width),
      Text(
        goals,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: AppColors.white,
          fontWeight: FontWeight.bold,
        ),
        overflow: TextOverflow.fade,
      ),
    ],
  );
}
