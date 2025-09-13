import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:live_score/src/core/extensions/nums.dart';

import '../../../../config/app_route.dart';
import '../../../../core/domain/entities/soccer_fixture.dart';
import '../../../../core/media_query.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import 'fixture_card.dart';
import 'live_fixtures_card.dart';
import 'no_fixtures_today.dart';
import 'view_all_tile.dart';

class ViewDayFixtures extends StatelessWidget {
  final List<SoccerFixture> fixtures;

  const ViewDayFixtures({super.key, required this.fixtures});

  @override
  Widget build(BuildContext context) {
    return fixtures.isNotEmpty
        ? Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.calendar_month, color: AppColors.blue),
                  SizedBox(width: 5.width),
                  Expanded(
                    child: Text(
                      AppStrings.fixtures,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  ViewAllTile(onTap: () => context.push(Routes.fixtures)),
                ],
              ),
              ...List.generate(fixtures.length, (index) {
                final String fixtureTime = fixtures[index].startTime.toString();
                final localTime = DateTime.parse(fixtureTime).toLocal();
                final formattedTime = DateFormat('h:mm a').format(localTime);
                return InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    context.push(Routes.fixtureDetails, extra: fixtures[index]);
                  },
                  child: FixtureCard(
                    soccerFixture: fixtures[index],
                    fixtureTime: formattedTime,
                  ),
                );
              }),
            ],
          ),
        )
        : SizedBox(height: context.height / 2, child: const NoFixturesView());
  }
}

class ViewLiveFixtures extends StatelessWidget {
  final List<SoccerFixture> fixtures;

  const ViewLiveFixtures({super.key, required this.fixtures});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      height: 280.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.stream, color: AppColors.red),
              SizedBox(width: 5.width),
              Expanded(
                child: Text(
                  AppStrings.liveFixtures,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
          SizedBox(height: 5.height),
          Expanded(
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    context.push(Routes.fixtureDetails, extra: fixtures[index]);
                  },
                  child: LiveFixtureCard(soccerFixture: fixtures[index]),
                );
              },
              separatorBuilder: (_, _) => SizedBox(width: 10.width),
              itemCount: fixtures.length,
            ),
          ),
        ],
      ),
    );
  }
}
