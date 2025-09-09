import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:live_score/src/core/extensions/fixture.dart';
import 'package:live_score/src/core/extensions/nums.dart';

import '../../../../core/domain/entities/soccer_fixture.dart';
import '../../../../core/media_query.dart';
import '../../../../core/utils/app_colors.dart';

class LiveFixtureCard extends StatelessWidget {
  final SoccerFixture soccerFixture;

  const LiveFixtureCard({super.key, required this.soccerFixture});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.all(20),
      width: context.width / 2.4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.radius),
        gradient: soccerFixture.gradientColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            soccerFixture.fixtureLeague.name,
            style: const TextStyle(color: AppColors.white),
            textAlign: TextAlign.center,
            overflow: TextOverflow.fade,
            softWrap: false,
          ),
          SizedBox(height: 15.height),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildTeamLogo(soccerFixture.teams.home.logo),
              buildTeamLogo(soccerFixture.teams.away.logo),
            ],
          ),
          SizedBox(height: 15.height),
          buildTeamTile(
            context: context,
            name: soccerFixture.teams.home.name,
            goals: soccerFixture.teams.home.score.toString(),
          ),
          SizedBox(height: 5.height),
          buildTeamTile(
            context: context,
            name: soccerFixture.teams.away.name,
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
}

Widget buildTeamLogo(String logo) => CircleAvatar(
  backgroundColor: AppColors.white,
  radius: 15.radius,
  child: CachedNetworkImage(
    fit: BoxFit.cover,
    width: 25.radius,
    height: 25.radius,
    imageUrl: logo,
    placeholder: (context, url) => const CircularProgressIndicator(),
    errorWidget: (context, url, error) => const Icon(Icons.error),
  ),
);

Widget buildTeamTile({
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
