import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_score/src/features/soccer/presentation/widgets/error_dialog.dart';
import 'package:live_score/src/features/soccer/presentation/widgets/no_fixtures_today.dart';

import '../../../../core/widgets/center_indicator.dart';
import '../../../settings/presentation/cubit/settings_cubit.dart';
import '../cubit/soccer_cubit.dart';
import '../cubit/soccer_state.dart';
import '../widgets/leagues_header.dart';
import '../widgets/view_fixtures.dart';

class SoccerScreen extends StatefulWidget {
  const SoccerScreen({super.key});

  @override
  State<SoccerScreen> createState() => _SoccerScreenState();
}

class _SoccerScreenState extends State<SoccerScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    context.read<SoccerCubit>().getTodayFixtures();
  }

  void _activateTimerFetching() {
    _timer ??= Timer.periodic(const Duration(minutes: 1), (timer) {
      context.read<SoccerCubit>().getTodayFixtures(isTimerLoading: true);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SettingsCubit, SettingsState>(
          listenWhen:
              (previous, current) => previous.language != current.language,
          listener: (context, state) {
            final cubit = context.read<SoccerCubit>();
            cubit.getLeagues(forceRefresh: true);
            cubit.getTodayFixtures();
          },
        ),
        BlocListener<SoccerCubit, SoccerStates>(
          listener: (context, state) {
            if (state is SoccerCurrentRoundFixturesLoadFailure) {
              ErrorDialog.show(
                context: context,
                message: state.message,
                onRetry: () {
                  if (state.competitionId != null) {
                    context.read<SoccerCubit>().getCurrentRoundFixtures(
                      competitionId: state.competitionId!,
                    );
                  }
                },
              );
            }
            if (state is SoccerTodayFixturesLoadFailure) {
              ErrorDialog.show(
                context: context,
                message: state.message,
                onRetry: context.read<SoccerCubit>().getTodayFixtures,
              );
            }
            if (state is SoccerLeaguesLoadFailure) {
              ErrorDialog.show(
                context: context,
                message: state.message,
                onRetry:
                    () => context.read<SoccerCubit>().getLeagues(
                      forceRefresh: true,
                    ),
              );
            }
            if (state is SoccerTodayFixturesLoaded) {
              if (state.liveFixtures.isNotEmpty) {
                _activateTimerFetching();
              } else {
                _timer?.cancel();
              }
            }
          },
        ),
      ],
      child: RefreshIndicator(
        onRefresh: context.read<SoccerCubit>().getTodayFixtures,
        child: const SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20,
            children: [
              SizedBox(height: 4),
              _LeaguesHeader(),
              _ViewFixtures(),
              SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }
}

class _LeaguesHeader extends StatelessWidget {
  const _LeaguesHeader();

  @override
  Widget build(BuildContext context) {
    final leagues = context.select(
      (SoccerCubit cubit) => cubit.availableLeagues,
    );
    final isLoading = context.select(
      (SoccerCubit cubit) => cubit.state is SoccerLeaguesLoading,
    );

    if (isLoading && leagues.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 32),
        child: CenterIndicator(),
      );
    }

    if (leagues.isNotEmpty) {
      return CircleLeaguesHeader(leagues: leagues);
    }

    return const SizedBox.shrink();
  }
}

class _ViewFixtures extends StatelessWidget {
  const _ViewFixtures();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SoccerCubit, SoccerStates>(
      buildWhen: (context, state) {
        if (state is SoccerTodayFixturesLoading && !state.isTimerLoading) {
          return true;
        }
        return [
          SoccerTodayFixturesLoaded,
          SoccerTodayFixturesLoadFailure,
        ].contains(state.runtimeType);
      },
      builder: (context, state) {
        if (state is SoccerTodayFixturesLoading) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 32),
            child: CenterIndicator(),
          );
        } else if (state is SoccerTodayFixturesLoaded) {
          if (state.todayFixtures.isNotEmpty) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12,
              children: [
                if (state.liveFixtures.isNotEmpty)
                  ViewLiveFixtures(fixtures: state.liveFixtures),
                if (state.todayFixtures.isNotEmpty)
                  ViewDayFixtures(fixtures: state.todayFixtures),
              ],
            );
          } else {
            return const NoFixturesView();
          }
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
