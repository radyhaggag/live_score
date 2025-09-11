import 'package:flutter/material.dart';
import 'package:live_score/src/core/domain/entities/teams.dart';
import 'package:live_score/src/core/extensions/nums.dart';
import 'package:live_score/src/core/extensions/strings.dart';
import 'package:live_score/src/core/media_query.dart';
import 'package:live_score/src/features/fixture/domain/entities/fixture_details.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_image.dart';
import 'items_not_available.dart';
import 'teams_lineups.dart';

class LineupsView extends StatelessWidget {
  final FixtureDetails? fixtureDetails;

  const LineupsView({super.key, required this.fixtureDetails});

  @override
  Widget build(BuildContext context) {
    final homeTeam = fixtureDetails?.fixture.teams.home;
    final awayTeam = fixtureDetails?.fixture.teams.away;
    return homeTeam?.lineup != null && awayTeam?.lineup != null
        ? Column(
          children: [
            buildTeamHeader(context: context, team: homeTeam!),
            Container(
              width: double.infinity,
              height: context.height * .8,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(AppAssets.playground),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ).copyWith(top: 20),
                child: TeamsLineups(fixtureDetails: fixtureDetails!),
              ),
            ),
            buildTeamHeader(context: context, team: awayTeam!),
          ],
        )
        : const ItemsNotAvailable(
          icon: Icons.people,
          message: AppStrings.noLineups,
        );
  }

  Widget buildTeamHeader({required BuildContext context, required Team team}) {
    return Container(
      color: AppColors.darkGreen,
      padding: const EdgeInsetsDirectional.all(5),
      child: Row(
        children: [
          CustomImage(
            width: 35.radius,
            height: 35.radius,
            imageUrl: team.logo,
          ),
          SizedBox(width: 10.width),
          Text(
            team.name.teamName,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const Spacer(),
          Text(
            team.lineup!.formation,
            style: const TextStyle(
              color: Colors.white,
              fontSize: FontSize.subTitle,
            ),
          ),
          SizedBox(width: 10.width),
        ],
      ),
    );
  }
}
