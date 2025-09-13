import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:live_score/src/core/extensions/color.dart';
import 'package:live_score/src/core/extensions/fixture.dart';
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
  int selectedTabIndex = 1;

  Timer? _timer;

  @override
  void initState() {
    super.initState();

    if (widget.soccerFixture.status.isLive) _activateTimerFetching();

    context.read<FixtureCubit>().getFixtureDetails(widget.soccerFixture.id);
    context.read<FixtureCubit>().getStatistics(widget.soccerFixture.id);
  }

  void _activateTimerFetching() {
    _timer ??= Timer.periodic(const Duration(minutes: 1), (timer) {
      context.read<FixtureCubit>().getFixtureDetails(
        widget.soccerFixture.id,
        isTimerLoading: true,
      );
      context.read<FixtureCubit>().getStatistics(
        widget.soccerFixture.id,
        isTimerLoading: true,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final FixtureCubit cubit = context.read<FixtureCubit>();
    final homeTeam = widget.soccerFixture.teams.home;
    final awayTeam = widget.soccerFixture.teams.away;

    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          child: Text(
            '${homeTeam.name.teamName} ${AppStrings.vs} ${awayTeam.name.teamName}',
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
      body: BlocBuilder<FixtureCubit, FixtureState>(
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async {
              await cubit.getFixtureDetails(widget.soccerFixture.id);
              await cubit.getStatistics(widget.soccerFixture.id);
            },
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                FixtureDetails(
                  soccerFixture:
                      cubit.fixtureDetails?.fixture ?? widget.soccerFixture,
                ),
                buildTabBar(cubit),
                if ((state is FixtureStatisticsLoading &&
                        !state.isTimerLoading) ||
                    (state is FixtureDetailsLoading && !state.isTimerLoading))
                  LinearProgressIndicator(color: _fixtureColor)
                else if (selectedTabIndex == 0)
                  StatisticsView(
                    key: ValueKey(
                      cubit.statistics?.hashCode ?? 'no_statistics',
                    ),
                    statistics: cubit.statistics,
                  )
                else if (selectedTabIndex == 1)
                  LineupsView(
                    key: ValueKey(
                      cubit.fixtureDetails?.hashCode ?? 'no_details',
                    ),
                    fixtureDetails: cubit.fixtureDetails,
                    color: _fixtureColor,
                  )
                else if (selectedTabIndex == 2)
                  EventsView(
                    key: ValueKey(
                      cubit.fixtureDetails?.hashCode ?? 'no_details',
                    ),
                    fixtureDetails: cubit.fixtureDetails,
                    color: _fixtureColor,
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildTabBar(FixtureCubit cubit) => Row(
    children: [
      Expanded(
        child: tabBarButton(
          label: AppStrings.statistics,
          onPressed: () => setState(() => selectedTabIndex = 0),
          isSelected: selectedTabIndex == 0,
        ),
      ),
      Expanded(
        child: tabBarButton(
          label: AppStrings.lineups,
          onPressed: () => setState(() => selectedTabIndex = 1),
          isSelected: selectedTabIndex == 1,
        ),
      ),
      Expanded(
        child: tabBarButton(
          label: AppStrings.events,
          onPressed: () => setState(() => selectedTabIndex = 2),
          isSelected: selectedTabIndex == 2,
        ),
      ),
    ],
  );

  Widget tabBarButton({
    required String label,
    required void Function()? onPressed,
    bool isSelected = false,
  }) => MaterialButton(
    onPressed: onPressed,
    color: isSelected ? _fixtureColor : _fixtureColor.withOpacitySafe(0.85),
    elevation: 0.0,
    padding: const EdgeInsets.all(16),
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    child: Text(
      label,
      style: Theme.of(
        context,
      ).textTheme.titleSmall?.copyWith(color: AppColors.white),
    ),
  );

  Color get _fixtureColor {
    return widget.soccerFixture.isThereWinner
        ? AppColors.lightRed
        : AppColors.darkBlue;
  }
}
