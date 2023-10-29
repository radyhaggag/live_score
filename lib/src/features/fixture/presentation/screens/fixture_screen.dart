import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../widgets/events_view.dart';
import '../widgets/lineups_view.dart';
import '../../../../core/domain/entities/soccer_fixture.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_values.dart';
import '../cubit/fixture_cubit.dart';
import '../widgets/fixture_details.dart';
import '../widgets/statistics_view.dart';

class FixtureScreen extends StatelessWidget {
  final SoccerFixture soccerFixture;

  const FixtureScreen({super.key, required this.soccerFixture});

  @override
  Widget build(BuildContext context) {
    FixtureCubit cubit = context.read<FixtureCubit>();

    return BlocBuilder<FixtureCubit, FixtureState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "${soccerFixture.teams.home.name} ${AppStrings.vs} ${soccerFixture.teams.away.name}",
            ),
          ),
          body: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              FixtureDetails(soccerFixture: soccerFixture),
              buildTabBar(cubit),
              if (state is FixtureStatisticsLoading ||
                  state is FixtureLineupsLoading ||
                  state is FixtureEventsLoading)
                LinearProgressIndicator(
                  color: getColor(soccerFixture),
                ),
              if (state is FixtureStatisticsLoaded)
                StatisticsView(statistics: state.statistics),
              if (state is FixtureLineupsLoaded)
                LineupsView(lineups: state.lineups),
              if (state is FixtureEventsLoaded)
                EventsView(
                  events: state.events,
                  color: getColor(soccerFixture),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget buildTabBar(FixtureCubit cubit) => Row(
        children: [
          Expanded(
            child: tabBarButton(
              label: AppStrings.statistics,
              onPressed: () async {
                if (soccerFixture.fixture.status.short != "NS") {
                  await cubit
                      .getStatistics(soccerFixture.fixture.id.toString());
                } else {
                  Fluttertoast.showToast(
                      msg: AppStrings.noStats,
                      backgroundColor: AppColors.blueGrey);
                }
              },
            ),
          ),
          Expanded(
            child: tabBarButton(
              label: AppStrings.lineups,
              onPressed: () async {
                await cubit.getLineups(soccerFixture.fixture.id.toString());
              },
            ),
          ),
          Expanded(
            child: tabBarButton(
              label: AppStrings.events,
              onPressed: () async {
                if (soccerFixture.fixture.status.short != "NS") {
                  await cubit.getEvents(soccerFixture.fixture.id.toString());
                } else {
                  Fluttertoast.showToast(
                      msg: AppStrings.noEvents,
                      backgroundColor: AppColors.blueGrey);
                }
              },
            ),
          ),
        ],
      );

  Widget tabBarButton(
          {required String label, required void Function()? onPressed}) =>
      MaterialButton(
        onPressed: onPressed,
        color: getColor(soccerFixture),
        elevation: 0.0,
        padding: const EdgeInsets.all(AppPadding.p16),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        child: Text(label, style: const TextStyle(color: AppColors.white)),
      );
}

Color getColor(SoccerFixture fixture) {
  Color color = AppColors.blueGrey;
  if (fixture.goals.away != fixture.goals.home) {
    color = AppColors.lightRed;
  }
  return color;
}
