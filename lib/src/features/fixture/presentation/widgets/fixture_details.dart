import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/domain/entities/soccer_fixture.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_size.dart';
import '../../../../core/utils/app_values.dart';
import '../../../soccer/presentation/screens/soccer_screen.dart';
import 'view_team.dart';

class FixtureDetails extends StatelessWidget {
  final SoccerFixture soccerFixture;

  const FixtureDetails({super.key, required this.soccerFixture});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p20),
      decoration: BoxDecoration(gradient: getGradientColor(soccerFixture)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                fit: BoxFit.cover,
                width: AppSize.s20,
                height: AppSize.s20,
                image: NetworkImage(soccerFixture.fixtureLeague.logo),
              ),
              const SizedBox(width: AppSize.s5),
              Text(
                soccerFixture.fixtureLeague.name,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: AppColors.white),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(height: AppSize.s10),
          Row(
            children: [
              Expanded(
                child: ViewTeam(team: soccerFixture.teams.home),
              ),
              (soccerFixture.fixture.status.elapsed != null)
                  ? Expanded(child: buildFixtureResult(context))
                  : Expanded(child: buildFixtureTime(context)),
              Expanded(
                child: ViewTeam(team: soccerFixture.teams.away),
              ),
            ],
          ),
          const SizedBox(height: AppSize.s10),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.p20, vertical: AppPadding.p5),
            decoration: BoxDecoration(
              color: AppColors.lightRed,
              borderRadius: BorderRadius.circular(AppSize.s20),
            ),
            child: Text(
              soccerFixture.fixture.status.long,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFixtureResult(BuildContext context) {
    TextStyle? displaySmall = Theme.of(context)
        .textTheme
        .displaySmall
        ?.copyWith(color: AppColors.white);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              soccerFixture.goals.home.toString(),
              style: displaySmall,
            ),
            const SizedBox(width: AppSize.s10),
            Text(
              ":",
              style: displaySmall,
            ),
            const SizedBox(width: AppSize.s10),
            Text(
              soccerFixture.goals.away.toString(),
              style: displaySmall,
            ),
          ],
        ),
        const SizedBox(height: AppSize.s5),
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
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: AppColors.white),
        ),
        const SizedBox(height: AppSize.s5),
        buildFixtureRound(context),
      ],
    );
  }

  Widget buildFixtureRound(BuildContext context) => Text(
        soccerFixture.fixtureLeague.round,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.white.withOpacity(0.9),
            ),
      );
}
