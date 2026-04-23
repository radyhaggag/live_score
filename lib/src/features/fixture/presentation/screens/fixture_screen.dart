import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:live_score/src/core/extensions/color.dart';
import 'package:live_score/src/core/extensions/fixture.dart';
import 'package:live_score/src/core/extensions/strings.dart';
import 'package:live_score/src/core/layout/adaptive_layout.dart';

import '../../../../core/domain/entities/soccer_fixture.dart';
import '../../../../core/l10n/app_l10n.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../settings/presentation/cubit/settings_cubit.dart';
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

    return BlocListener<SettingsCubit, SettingsState>(
      listenWhen: (previous, current) => previous.language != current.language,
      listener: (context, state) {
        context.read<FixtureCubit>().getFixtureDetails(widget.soccerFixture.id);
        context.read<FixtureCubit>().getStatistics(widget.soccerFixture.id);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, size: 16),
            onPressed: () => context.pop(),
          ),
          title: FittedBox(
            child: Text(
              '${homeTeam.name.teamName} ${context.l10n.versus} ${awayTeam.name.teamName}',
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: BlocBuilder<FixtureCubit, FixtureState>(
          builder: (context, state) {
            final fixture =
                cubit.fixtureDetails?.fixture ?? widget.soccerFixture;
            final isLoading =
                (state is FixtureStatisticsLoading && !state.isTimerLoading) ||
                (state is FixtureDetailsLoading && !state.isTimerLoading);

            return RefreshIndicator(
              onRefresh: () async {
                await cubit.getFixtureDetails(widget.soccerFixture.id);
                await cubit.getStatistics(widget.soccerFixture.id);
              },
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                children: [
                  FixtureDetails(soccerFixture: fixture),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      context.pageHorizontalPadding,
                      12,
                      context.pageHorizontalPadding,
                      20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildTabBar(context),
                        if (isLoading)
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: LinearProgressIndicator(
                              color: _fixtureColor,
                            ),
                          )
                        else
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: _buildSelectedContent(cubit),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSelectedContent(FixtureCubit cubit) {
    if (selectedTabIndex == 0) {
      return StatisticsView(
        key: ValueKey(cubit.statistics?.hashCode ?? 'no_statistics'),
        statistics: cubit.statistics,
      );
    }

    if (selectedTabIndex == 1) {
      return LineupsView(
        key: ValueKey(cubit.fixtureDetails?.hashCode ?? 'no_details'),
        fixtureDetails: cubit.fixtureDetails,
        color: _fixtureColor,
      );
    }

    return EventsView(
      key: ValueKey(cubit.fixtureDetails?.hashCode ?? 'no_details'),
      fixtureDetails: cubit.fixtureDetails,
      color: _fixtureColor,
    );
  }

  Widget buildTabBar(BuildContext context) {
    final buttons = [
      _tabBarButton(
        context: context,
        label: context.l10n.statistics,
        onPressed: () => setState(() => selectedTabIndex = 0),
        isSelected: selectedTabIndex == 0,
      ),
      _tabBarButton(
        context: context,
        label: context.l10n.lineups,
        onPressed: () => setState(() => selectedTabIndex = 1),
        isSelected: selectedTabIndex == 1,
      ),
      _tabBarButton(
        context: context,
        label: context.l10n.events,
        onPressed: () => setState(() => selectedTabIndex = 2),
        isSelected: selectedTabIndex == 2,
      ),
    ];

    return DecoratedBox(
      decoration: BoxDecoration(
        color: _fixtureColor.withOpacitySafe(0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Row(children: buttons),
      ),
    );
  }

  Widget _tabBarButton({
    required BuildContext context,
    required String label,
    required void Function()? onPressed,
    bool isSelected = false,
  }) => Expanded(
    child: Padding(
      padding: const EdgeInsets.all(4),
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor:
              isSelected ? _fixtureColor : _fixtureColor.withOpacitySafe(0.72),
          foregroundColor: AppColors.white,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Text(label, textAlign: TextAlign.center),
      ),
    ),
  );

  Color get _fixtureColor {
    return widget.soccerFixture.isThereWinner
        ? AppColors.lightRed
        : AppColors.darkBlue;
  }
}
