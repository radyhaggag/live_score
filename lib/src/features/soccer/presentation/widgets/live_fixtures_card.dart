import 'package:flutter/material.dart';
import 'package:live_score/src/core/extensions/fixture.dart';
import 'package:live_score/src/core/extensions/strings.dart';

import '../../../../core/domain/entities/soccer_fixture.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_image.dart';
import '../../../../core/widgets/match_time_with_progress.dart';

class LiveFixtureCard extends StatelessWidget {
  final SoccerFixture soccerFixture;
  final double? width;

  const LiveFixtureCard({super.key, required this.soccerFixture, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: soccerFixture.gradientColor,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isTightCard =
              constraints.maxWidth < 210 || constraints.maxHeight < 250;
          final isVeryTightCard =
              constraints.maxWidth < 195 || constraints.maxHeight < 235;
          final horizontalPadding = isVeryTightCard ? 12.0 : 15.0;
          final verticalPadding =
              isVeryTightCard
                  ? 6.0
                  : isTightCard
                  ? 7.0
                  : 9.0;
          final contentSpacing =
              isVeryTightCard
                  ? 4.0
                  : isTightCard
                  ? 6.0
                  : 10.0;
          final leagueLogoSize =
              isVeryTightCard
                  ? 18.0
                  : isTightCard
                  ? 22.0
                  : 26.0;
          final leagueLogoPadding = isVeryTightCard ? 2.0 : 4.0;
          final teamLogoRadius =
              isVeryTightCard
                  ? 10.0
                  : isTightCard
                  ? 12.0
                  : 14.0;
          final teamLogoSize =
              isVeryTightCard
                  ? 15.0
                  : isTightCard
                  ? 19.0
                  : 22.0;
          final statusHorizontalPadding =
              isVeryTightCard
                  ? 10.0
                  : isTightCard
                  ? 12.0
                  : 16.0;
          final leagueTextStyle = (isVeryTightCard
                  ? Theme.of(context).textTheme.labelSmall
                  : Theme.of(context).textTheme.bodySmall)
              ?.copyWith(color: AppColors.white, fontWeight: FontWeight.bold);
          final teamTextStyle = (isVeryTightCard
                  ? Theme.of(context).textTheme.bodySmall
                  : Theme.of(context).textTheme.bodyMedium)
              ?.copyWith(color: AppColors.white);
          final goalsTextStyle = (isVeryTightCard
                  ? Theme.of(context).textTheme.titleSmall
                  : Theme.of(context).textTheme.bodyLarge)
              ?.copyWith(color: AppColors.white, fontWeight: FontWeight.bold);
          final statusTextStyle = (isVeryTightCard
                  ? Theme.of(context).textTheme.labelSmall
                  : Theme.of(context).textTheme.bodySmall)
              ?.copyWith(color: AppColors.red, fontWeight: FontWeight.bold);

          return Padding(
            padding: EdgeInsetsDirectional.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            child: Column(
              mainAxisAlignment:
                  isVeryTightCard
                      ? MainAxisAlignment.spaceEvenly
                      : MainAxisAlignment.center,
              spacing: contentSpacing,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: isVeryTightCard ? 6 : 8,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(leagueLogoPadding),
                      child: CustomImage(
                        height: leagueLogoSize,
                        width: leagueLogoSize,
                        imageUrl: soccerFixture.fixtureLeague.logo,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        soccerFixture.fixtureLeague.name,
                        style: leagueTextStyle,
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
                    _buildTeamLogo(
                      soccerFixture.teams.home.logo,
                      radius: teamLogoRadius,
                      imageSize: teamLogoSize,
                    ),
                    _buildTeamLogo(
                      soccerFixture.teams.away.logo,
                      radius: teamLogoRadius,
                      imageSize: teamLogoSize,
                    ),
                  ],
                ),
                _buildTeamTile(
                  context: context,
                  name: soccerFixture.teams.home.name.teamName,
                  goals: soccerFixture.teams.home.score.toString(),
                  teamTextStyle: teamTextStyle,
                  goalsTextStyle: goalsTextStyle,
                ),
                _buildTeamTile(
                  context: context,
                  name: soccerFixture.teams.away.name.teamName,
                  goals: soccerFixture.teams.away.score.toString(),
                  teamTextStyle: teamTextStyle,
                  goalsTextStyle: goalsTextStyle,
                ),
                MatchTimeWithProgress(
                  time: soccerFixture.gameTimeDisplay,
                  mainColor: AppColors.white,
                  widthFactor: isVeryTightCard ? 2 : 3,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: statusHorizontalPadding,
                    vertical:
                        isVeryTightCard
                            ? 3
                            : isTightCard
                            ? 4
                            : 5,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    soccerFixture.statusText,
                    style: statusTextStyle,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTeamLogo(
    String logo, {
    required double radius,
    required double imageSize,
  }) => CircleAvatar(
    backgroundColor: AppColors.white,
    radius: radius,
    child: CustomImage(width: imageSize, height: imageSize, imageUrl: logo),
  );

  Widget _buildTeamTile({
    required String name,
    required String goals,
    required BuildContext context,
    required TextStyle? teamTextStyle,
    required TextStyle? goalsTextStyle,
  }) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: Text(
          name,
          maxLines: 1,
          softWrap: false,
          overflow: TextOverflow.ellipsis,
          style: teamTextStyle,
        ),
      ),
      const SizedBox(width: 10),
      Text(goals, style: goalsTextStyle),
    ],
  );
}
