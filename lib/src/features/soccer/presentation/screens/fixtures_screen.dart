import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:live_score/src/core/extensions/nums.dart';

import '../cubit/soccer_cubit.dart';
import '../cubit/soccer_state.dart';
import '../widgets/fixture_card.dart';
import '../widgets/leagues_header.dart';
import '../widgets/no_fixtures_today.dart';

class FixturesScreen extends StatelessWidget {
  const FixturesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SoccerCubit cubit = context.read<SoccerCubit>();
    return BlocBuilder<SoccerCubit, SoccerStates>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RectLeaguesHeader(
              leagues: cubit.filteredLeagues,
              getFixtures: true,
            ),
            SizedBox(height: 10.height),
            cubit.currentFixtures.isNotEmpty
                ? Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      String fixtureTime =
                          cubit.currentFixtures[index].fixture.date;
                      final localTime = DateTime.parse(fixtureTime).toLocal();
                      final formattedTime = DateFormat(
                        "h:mm a",
                      ).format(localTime);
                      return FixtureCard(
                        soccerFixture: cubit.currentFixtures[index],
                        fixtureTime: formattedTime,
                      );
                    },
                    itemCount: cubit.currentFixtures.length,
                  ),
                )
                : const NoFixturesToday(),
          ],
        );
      },
    );
  }
}
