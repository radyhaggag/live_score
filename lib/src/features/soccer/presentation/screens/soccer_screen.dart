import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_score/src/core/widgets/app_error_dialog.dart';
import '../../../../core/widgets/app_empty.dart';
import '../../../../core/widgets/settings_language_listener.dart';

import '../../../../core/widgets/app_loading.dart';
import '../cubit/leagues_cubit.dart';
import '../cubit/leagues_state.dart';
import '../cubit/soccer_cubit.dart';
import '../cubit/soccer_state.dart';
import '../widgets/leagues_header.dart';
import '../widgets/view_fixtures.dart';
import 'package:live_score/src/core/constants/app_spacing.dart';

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
        SettingsLanguageListener(
          onLanguageChanged: (context, state) {
            final cubit = context.read<SoccerCubit>();
            context.read<LeaguesCubit>().getLeagues(forceRefresh: true);
            cubit.getTodayFixtures();
          },
        ),
        BlocListener<SoccerCubit, SoccerState>(
          listener: (context, state) {
            if (state is SoccerCurrentRoundFixturesLoadFailure) {
              AppErrorDialog.show(
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
              AppErrorDialog.show(
                context: context,
                message: state.message,
                onRetry: context.read<SoccerCubit>().getTodayFixtures,
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
        BlocListener<LeaguesCubit, LeaguesState>(
          listener: (context, state) {
            if (state is LeaguesLoadFailure) {
              AppErrorDialog.show(
                context: context,
                message: state.message,
                onRetry:
                    () => context.read<LeaguesCubit>().getLeagues(
                      forceRefresh: true,
                    ),
              );
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
              SizedBox(height: AppSpacing.xs),
              _LeaguesHeader(),
              _ViewFixtures(),
              SizedBox(height: AppSpacing.xs),
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
      (LeaguesCubit cubit) => cubit.availableLeagues,
    );
    final isLoading = context.select(
      (LeaguesCubit cubit) => cubit.state is LeaguesLoading,
    );

    if (isLoading && leagues.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 32),
        child: AppLoadingIndicator(),
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
    return BlocBuilder<SoccerCubit, SoccerState>(
      buildWhen: (context, state) {
        if (state is SoccerTodayFixturesLoading && !state.isTimerLoading) {
          return true;
        }
        return state is SoccerTodayFixturesLoaded ||
            state is SoccerTodayFixturesLoadFailure;
      },
      builder: (context, state) {
        if (state is SoccerTodayFixturesLoading) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 32),
            child: AppLoadingIndicator(),
          );
        } else if (state is SoccerTodayFixturesLoaded) {
          if (state.todayFixtures.isNotEmpty) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12,
              children: [
                if (state.liveFixtures.isNotEmpty)
                  RepaintBoundary(
                    child: ViewLiveFixtures(fixtures: state.liveFixtures),
                  ),
                if (state.todayFixtures.isNotEmpty)
                  ViewDayFixtures(fixtures: state.todayFixtures),
              ],
            );
          } else {
            return const AppEmptyWidget();
          }
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
