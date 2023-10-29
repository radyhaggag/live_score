import 'package:flutter/material.dart';

import '../../../../core/domain/entities/soccer_fixture.dart';
import '../../../../core/media_query.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_size.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_values.dart';
import '../screens/soccer_screen.dart';

class LiveFixtureCard extends StatelessWidget {
  final SoccerFixture soccerFixture;

  const LiveFixtureCard({super.key, required this.soccerFixture});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.all(AppPadding.p20),
      width: context.width / 2.4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s20),
        gradient: getGradientColor(soccerFixture),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            soccerFixture.fixtureLeague.name,
            style: const TextStyle(color: AppColors.white),
            textAlign: TextAlign.center,
            overflow: TextOverflow.fade,
            softWrap: false,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildTeamLogo(soccerFixture.teams.home.logo),
              buildTeamLogo(soccerFixture.teams.away.logo),
            ],
          ),
          buildTeamTile(
            context: context,
            name: soccerFixture.teams.home.name,
            goals: soccerFixture.goals.home.toString(),
          ),
          buildTeamTile(
            context: context,
            name: soccerFixture.teams.away.name,
            goals: soccerFixture.goals.away.toString(),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p20,
              vertical: AppPadding.p5,
            ),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppSize.s20),
            ),
            child: Text(
              AppStrings.live,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: AppColors.red),
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
      radius: AppSize.s25,
      child: Image(
        fit: BoxFit.cover,
        width: AppSize.s30,
        height: AppSize.s30,
        image: NetworkImage(logo),
      ),
    );

Widget buildTeamTile(
        {required String name,
        required String goals,
        required BuildContext context}) =>
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            name,
            softWrap: false,
            overflow: TextOverflow.fade,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppColors.white),
          ),
        ),
        const SizedBox(width: AppSize.s10),
        Text(
          goals.toString(),
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: AppColors.white),
          overflow: TextOverflow.fade,
        ),
      ],
    );
