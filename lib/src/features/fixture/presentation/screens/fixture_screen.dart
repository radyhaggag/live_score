import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:live_score/src/core/extensions/fixture.dart';
import 'package:live_score/src/core/extensions/strings.dart';
import 'package:live_score/src/core/layout/adaptive_layout.dart';

import '../../../../core/widgets/app_loading.dart';
import '../../../../core/widgets/settings_language_listener.dart';
import '../../../../core/domain/entities/soccer_fixture.dart';
import '../../../../core/l10n/app_l10n.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../domain/entities/fixture_details.dart';
import '../../domain/entities/statistics.dart';
import '../cubit/fixture_cubit.dart';
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
  Statistics? _statistics;
  FixtureDetails? _fixtureDetails;

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

  Color get _fixtureColor =>
      widget.soccerFixture.isThereWinner
          ? context.colorsExt.lightRed
          : context.colorsExt.darkBlue;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FixtureCubit>();
    final homeTeam = widget.soccerFixture.teams.home;
    final awayTeam = widget.soccerFixture.teams.away;

    return SettingsLanguageListener(
      onLanguageChanged: (context, state) {
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
        body: BlocListener<FixtureCubit, FixtureState>(
          listener: (context, state) {
            if (state is FixtureStatisticsLoaded) {
              setState(() => _statistics = state.statistics);
            } else if (state is FixtureDetailsLoaded) {
              setState(() => _fixtureDetails = state.fixtureDetails);
            }
          },
          child: BlocSelector<FixtureCubit, FixtureState, bool>(
            selector: (state) {
              return (state is FixtureStatisticsLoading &&
                      !state.isTimerLoading) ||
                  (state is FixtureDetailsLoading && !state.isTimerLoading);
            },
            builder: (context, isLoading) {
              final fixture = _fixtureDetails?.fixture ?? widget.soccerFixture;

              return RefreshIndicator(
                onRefresh: () async {
                  await cubit.getFixtureDetails(widget.soccerFixture.id);
                  await cubit.getStatistics(widget.soccerFixture.id);
                },
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  children: [
                    detail_widget.FixtureDetails(soccerFixture: fixture),
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
                          FixtureTabBar(
                            selectedIndex: _selectedTabIndex,
                            fixtureColor: _fixtureColor,
                            onTabSelected:
                                (i) => setState(() => _selectedTabIndex = i),
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
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: FixtureTabContent(
                                selectedIndex: _selectedTabIndex,
                                statistics: _statistics,
                                fixtureDetails: _fixtureDetails,
                                fixtureColor: _fixtureColor,
                              ),
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
      ),
    );
  }
}
