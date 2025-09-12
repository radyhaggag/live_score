import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:live_score/src/core/extensions/nums.dart';
import 'package:live_score/src/core/extensions/strings.dart';

import '../../../../core/domain/entities/soccer_fixture.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../cubit/fixture_cubit.dart';
import '../widgets/events_view.dart';
import '../widgets/fixture_details.dart';
import '../widgets/lineups_view.dart';
import '../widgets/statistics_view.dart';

class FixtureScreen extends StatefulWidget {
  final SoccerFixture soccerFixture;

  const FixtureScreen({super.key, required this.soccerFixture});

  @override
  State<FixtureScreen> createState() => _FixtureScreenState();
}

class _FixtureScreenState extends State<FixtureScreen> {
  int selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();

    context.read<FixtureCubit>().getFixtureDetails(widget.soccerFixture.id);
    context.read<FixtureCubit>().getStatistics(widget.soccerFixture.id);
  }

  @override
  Widget build(BuildContext context) {
    FixtureCubit cubit = context.read<FixtureCubit>();

    return BlocBuilder<FixtureCubit, FixtureState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: FittedBox(
              child: Text(
                "${widget.soccerFixture.teams.home.name.teamName} ${AppStrings.vs} ${widget.soccerFixture.teams.away.name.teamName}",
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new, size: 15.radius),
              onPressed: () => context.pop(),
            ),
          ),
          body: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              FixtureDetails(soccerFixture: widget.soccerFixture),
              buildTabBar(cubit),
              if (state is FixtureStatisticsLoading ||
                  state is FixtureDetailsLoading)
                LinearProgressIndicator(color: getColor(widget.soccerFixture))
              else if (selectedTabIndex == 0)
                StatisticsView(statistics: cubit.statistics)
              else if (selectedTabIndex == 1)
                LineupsView(
                  fixtureDetails: cubit.fixtureDetails,
                  color: getColor(widget.soccerFixture),
                )
              else if (selectedTabIndex == 2)
                EventsView(
                  fixtureDetails: cubit.fixtureDetails,
                  color: getColor(widget.soccerFixture),
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
          onPressed: () => setState(() => selectedTabIndex = 0),
        ),
      ),
      Expanded(
        child: tabBarButton(
          label: AppStrings.lineups,
          onPressed: () => setState(() => selectedTabIndex = 1),
        ),
      ),
      Expanded(
        child: tabBarButton(
          label: AppStrings.events,
          onPressed: () => setState(() => selectedTabIndex = 2),
        ),
      ),
    ],
  );

  Widget tabBarButton({
    required String label,
    required void Function()? onPressed,
  }) => MaterialButton(
    onPressed: onPressed,
    color: getColor(widget.soccerFixture),
    elevation: 0.0,
    padding: const EdgeInsets.all(16),
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    child: Text(label, style: const TextStyle(color: AppColors.white)),
  );
}

Color getColor(SoccerFixture fixture) {
  Color color = AppColors.blueGrey;
  if (fixture.teams.away.score != fixture.teams.home.score) {
    color = AppColors.lightRed;
  }
  return color;
}
