import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:live_score/src/core/extensions/fixture.dart';
import 'package:live_score/src/core/layout/adaptive_layout.dart';

import '../../../../core/domain/entities/soccer_fixture.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../../core/l10n/app_l10n.dart';
import '../../../../core/widgets/app_loading.dart';
import '../../../../core/widgets/settings_language_listener.dart';
import '../../domain/entities/fixture_details.dart';
import '../../domain/entities/statistics.dart';
import '../cubit/fixture/fixture_cubit.dart';
import '../cubit/statistics/statistics_cubit.dart';
import '../widgets/fixture_details.dart' as detail_widget;
import '../widgets/fixture_tab_bar.dart';

class FixtureScreen extends StatefulWidget {
  final SoccerFixture soccerFixture;

  const FixtureScreen({super.key, required this.soccerFixture});

  @override
  State<FixtureScreen> createState() => _FixtureScreenState();
}

class _FixtureScreenState extends State<FixtureScreen> {
  int _selectedTabIndex = 1;
  Timer? _timer;

  // Each stream is cached independently — no race condition possible.
  Statistics? _statistics;
  FixtureDetails? _fixtureDetails;

  late ScrollController _scrollController;
  double _appBarOpacity = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    if (widget.soccerFixture.status.isLive) _activateTimerFetching();
    context.read<FixtureCubit>().getFixtureDetails(widget.soccerFixture.id);
    context.read<StatisticsCubit>().getStatistics(widget.soccerFixture.id);
  }

  void _onScroll() {
    final double offset = _scrollController.offset;
    final double newOpacity = (offset / 100).clamp(0, 1);
    if (newOpacity != _appBarOpacity) {
      setState(() => _appBarOpacity = newOpacity);
    }
  }

  void _activateTimerFetching() {
    _timer ??= Timer.periodic(const Duration(minutes: 1), (timer) {
      context.read<FixtureCubit>().getFixtureDetails(
        widget.soccerFixture.id,
        isTimerLoading: true,
      );
      context.read<StatisticsCubit>().getStatistics(
        widget.soccerFixture.id,
        isTimerLoading: true,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  Color get _fixtureColor =>
      widget.soccerFixture.isThereWinner
          ? context.colorsExt.lightRed
          : context.colorsExt.darkBlue;

  @override
  Widget build(BuildContext context) {
    final homeTeam = widget.soccerFixture.teams.home;
    final awayTeam = widget.soccerFixture.teams.away;

    return SettingsLanguageListener(
      onLanguageChanged: (context, state) {
        context.read<FixtureCubit>().getFixtureDetails(widget.soccerFixture.id);
        context.read<StatisticsCubit>().getStatistics(widget.soccerFixture.id);
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor:
              _appBarOpacity > 0
                  ? _fixtureColor.withValues(alpha: _appBarOpacity)
                  : Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              size: 20,
              color: Colors.white,
            ),
            onPressed: () => context.pop(),
          ),
          title: AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: _appBarOpacity,
            child: FittedBox(
              child: Text(
                '${homeTeam.displayName} ${context.l10n.versus} ${awayTeam.displayName}',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          centerTitle: true,
        ),
        body: MultiBlocListener(
          listeners: [
            // Statistics stream — updates independently.
            BlocListener<StatisticsCubit, StatisticsState>(
              listener: (context, state) {
                if (state is StatisticsLoaded) {
                  setState(() => _statistics = state.statistics);
                }
              },
            ),
            // Fixture details stream — updates independently.
            BlocListener<FixtureCubit, FixtureState>(
              listener: (context, state) {
                if (state is FixtureDetailsLoaded) {
                  setState(() => _fixtureDetails = state.fixtureDetails);
                }
              },
            ),
          ],
          child: BlocBuilder<FixtureCubit, FixtureState>(
            buildWhen:
                (prev, curr) =>
                    // Only rebuild the loading indicator when initial loading changes.
                    (curr is FixtureDetailsLoading && !curr.isTimerLoading) ||
                    (prev is FixtureDetailsLoading &&
                        curr is! FixtureDetailsLoading),
            builder: (context, fixtureState) {
              // Also watch statistics loading state for the shared indicator.
              return BlocBuilder<StatisticsCubit, StatisticsState>(
                buildWhen:
                    (prev, curr) =>
                        (curr is StatisticsLoading && !curr.isTimerLoading) ||
                        (prev is StatisticsLoading &&
                            curr is! StatisticsLoading),
                builder: (context, statisticsState) {
                  final isLoading =
                      (fixtureState is FixtureDetailsLoading &&
                          !fixtureState.isTimerLoading) ||
                      (statisticsState is StatisticsLoading &&
                          !statisticsState.isTimerLoading);

                  final fixture =
                      _fixtureDetails?.fixture ?? widget.soccerFixture;

                  return RefreshIndicator(
                    onRefresh: () async {
                      await Future.wait([
                        context.read<FixtureCubit>().getFixtureDetails(
                          widget.soccerFixture.id,
                        ),
                        context.read<StatisticsCubit>().getStatistics(
                          widget.soccerFixture.id,
                        ),
                      ]);
                    },
                    child: CustomScrollView(
                      controller: _scrollController,
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        SliverToBoxAdapter(
                          child: detail_widget.FixtureDetails(
                            soccerFixture: fixture,
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                              context.pageHorizontalPadding / 2,
                              8,
                              context.pageHorizontalPadding / 2,
                              8,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FixtureTabBar(
                                  selectedIndex: _selectedTabIndex,
                                  fixtureColor: _fixtureColor,
                                  onTabSelected: (i) {
                                    setState(() => _selectedTabIndex = i);
                                  },
                                ),
                                if (isLoading)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12),
                                    child: AppLoadingIndicator(
                                      isLinear: true,
                                      color: _fixtureColor,
                                    ),
                                  )
                                else
                                  AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 300),
                                    child: FixtureTabContent(
                                      key: ValueKey(_selectedTabIndex),
                                      selectedIndex: _selectedTabIndex,
                                      statistics: _statistics,
                                      fixtureDetails: _fixtureDetails,
                                      fixtureColor: _fixtureColor,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
