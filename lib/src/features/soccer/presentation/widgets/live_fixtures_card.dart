import 'package:flutter/material.dart';
import 'package:live_score/src/core/constants/app_spacing.dart';
import 'package:live_score/src/core/extensions/fixture.dart';
import 'package:live_score/src/core/extensions/responsive_size.dart';
import 'package:live_score/src/core/extensions/strings.dart';

import '../../../../core/domain/entities/soccer_fixture.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../../core/widgets/custom_image.dart';
import '../../../../core/widgets/match_time_with_progress.dart';
import 'live_team_logo.dart';
import 'live_team_tile.dart';

/// A compact card displaying a live fixture in the horizontal rail.
class LiveFixtureCard extends StatelessWidget {
  final SoccerFixture soccerFixture;
  final double? width;

  const LiveFixtureCard({super.key, required this.soccerFixture, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 200.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        gradient: soccerFixture.gradientColor(context),
      ),
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.l,
        vertical: AppSpacing.m,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: AppSpacing.m,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: AppSpacing.s,
            children: [
              CustomImage(
                height: 22.w,
                width: 22.w,
                imageUrl: soccerFixture.fixtureLeague.logo,
              ),
              Flexible(
                child: Text(
                  soccerFixture.fixtureLeague.name,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: context.colorsExt.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              LiveTeamLogo(
                logo: soccerFixture.teams.home.logo,
                radius: 14.r,
                imageSize: 22.w,
              ),
              LiveTeamLogo(
                logo: soccerFixture.teams.away.logo,
                radius: 14.r,
                imageSize: 22.w,
              ),
            ],
          ),
          LiveTeamTile(
            name: soccerFixture.teams.home.name.teamName,
            goals: soccerFixture.teams.home.score.toString(),
            teamTextStyle: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: context.colorsExt.white),
            goalsTextStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: context.colorsExt.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          LiveTeamTile(
            name: soccerFixture.teams.away.name.teamName,
            goals: soccerFixture.teams.away.score.toString(),
            teamTextStyle: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: context.colorsExt.white),
            goalsTextStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: context.colorsExt.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          MatchTimeWithProgress(
            time: soccerFixture.gameTimeDisplay,
            mainColor: context.colorsExt.white,
            widthFactor: 3,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.l,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: context.colorsExt.white,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              soccerFixture.statusText,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: context.colorsExt.red,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
