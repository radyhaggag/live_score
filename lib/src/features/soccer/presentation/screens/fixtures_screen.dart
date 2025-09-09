import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:live_score/src/core/extensions/nums.dart';
import 'package:live_score/src/core/utils/app_fonts.dart';

import '../../../../core/domain/entities/soccer_fixture.dart';
import '../cubit/soccer_cubit.dart';
import '../cubit/soccer_state.dart';
import '../widgets/fixture_card.dart';
import '../widgets/leagues_header.dart';
import '../widgets/no_fixtures_today.dart';

class FixturesScreen extends StatefulWidget {
  const FixturesScreen({super.key, this.competitionId});

  final int? competitionId;

  @override
  State<FixturesScreen> createState() => _FixturesScreenState();
}

class _FixturesScreenState extends State<FixturesScreen> {
  int? selectedLeagueId;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final availableLeagues = context.read<SoccerCubit>().availableLeagues;
      selectedLeagueId = widget.competitionId ?? availableLeagues.first.id;
      if (availableLeagues.isEmpty) return;
      context.read<SoccerCubit>().getCurrentRoundFixtures(
        competitionId: selectedLeagueId!,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    SoccerCubit cubit = context.read<SoccerCubit>();
    return BlocBuilder<SoccerCubit, SoccerStates>(
      buildWhen: (previous, current) {
        return [
          SoccerFixturesLoaded,
          SoccerFixturesLoading,
          SoccerFixturesLoadFailure,
          SoccerCurrentRoundFixturesLoaded,
        ].contains(current.runtimeType);
      },
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RectLeaguesHeader(
              leagues: cubit.availableLeagues,
              getFixtures: true,
              selectedLeagueId: selectedLeagueId,
            ),
            SizedBox(height: 10.height),
            if (state is SoccerFixturesLoading)
              const LinearProgressIndicator()
            else if (state is SoccerCurrentRoundFixturesLoaded &&
                state.fixtures.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: _buildGroupedFixtures(state.fixtures).length,
                  itemBuilder: (context, index) {
                    final item = _buildGroupedFixtures(state.fixtures)[index];

                    if (item is String) {
                      // Date header
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 12,
                        ),
                        child: Text(
                          item,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(fontWeight: FontWeights.semiBold),
                        ),
                      );
                    } else {
                      // FixtureCard
                      final fixture = item;
                      final gameTime = fixture.startTime.toString();
                      final localTime = DateTime.parse(gameTime).toLocal();
                      final formattedTime = DateFormat(
                        "h:mm a",
                      ).format(localTime);

                      return FixtureCard(
                        soccerFixture: fixture,
                        fixtureTime: formattedTime,
                      );
                    }
                  },
                ),
              )
            else if (state is SoccerCurrentRoundFixturesLoaded &&
                state.fixtures.isEmpty)
              NoFixturesView()
            else
              const SizedBox.shrink(),
          ],
        );
      },
    );
  }

  /// Groups fixtures by day and returns a mixed list of [String date headers + fixtures]
  List<dynamic> _buildGroupedFixtures(List<SoccerFixture> fixtures) {
    fixtures.sort((a, b) {
      if (a.startTime == null || b.startTime == null) return 0;
      return a.startTime!.compareTo(b.startTime!);
    });

    List<dynamic> groupedList = [];
    String? lastDate;

    final now = DateTime.now();

    for (var fixture in fixtures) {
      if (fixture.startTime == null) continue;

      final localDate = fixture.startTime!.toLocal();
      final isSameYear = localDate.year == now.year;

      // Format: add year only if not current year
      final fixtureDate = DateFormat(
        isSameYear ? "EEEE, MMM d" : "EEEE, MMM d, yyyy",
      ).format(localDate);

      if (lastDate != fixtureDate) {
        groupedList.add(fixtureDate); // Add header
        lastDate = fixtureDate;
      }
      groupedList.add(fixture);
    }

    return groupedList;
  }
}
