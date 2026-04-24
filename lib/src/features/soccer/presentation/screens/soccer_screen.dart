import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_score/src/core/constants/app_spacing.dart';
import 'package:live_score/src/core/widgets/app_error_dialog.dart';

import '../../../../core/utils/app_animations.dart';
import '../../../../core/widgets/app_empty.dart';
import '../../../../core/widgets/app_loading.dart';
import '../../../../core/widgets/leagues_header.dart';
import '../../../../core/widgets/settings_language_listener.dart';
import '../cubit/leagues/leagues_cubit.dart';
import '../cubit/leagues/leagues_state.dart';
import '../cubit/soccer/soccer_cubit.dart';
import '../cubit/soccer/soccer_state.dart';
import '../widgets/modal_sheet_content.dart';
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
    _timer ??= Timer.periodic(const Duration(minutes: 1), (_) {
      context.read<SoccerCubit>().getTodayFixtures(isTimerLoading: true);
    });
  }

  void _onSoccerStateChange(BuildContext context, SoccerState state) {
    switch (state) {
      case SoccerCurrentRoundFixturesLoadFailure():
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
      case SoccerTodayFixturesLoadFailure():
        AppErrorDialog.show(
          context: context,
          message: state.message,
          onRetry: context.read<SoccerCubit>().getTodayFixtures,
        );
      case SoccerTodayFixturesLoaded():
        if (state.liveFixtures.isNotEmpty) {
          _activateTimerFetching();
        } else {
          _timer?.cancel();
        }
      default:
        break;
    }
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
            context.read<LeaguesCubit>().getLeagues(forceRefresh: true);
            context.read<SoccerCubit>().getTodayFixtures();
          },
        ),
        BlocListener<SoccerCubit, SoccerState>(listener: _onSoccerStateChange),
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
          physics: BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          padding: EdgeInsets.only(bottom: 120), // Padding for floating nav bar
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppSpacing.xl,
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
        padding: EdgeInsets.symmetric(vertical: AppSpacing.xxxl),
        child: AppLoadingIndicator(),
      );
    }

    if (leagues.isNotEmpty) {
      return CircleLeaguesHeader(
        leagues: leagues,
        onLeagueTap: (ctx, league) {
          buildBottomSheet(
            context: ctx,
            league: league,
            cubit: ctx.read<SoccerCubit>(),
          );
        },
      );
    }

    return const SizedBox.shrink();
  }
}

class _ViewFixtures extends StatelessWidget {
  const _ViewFixtures();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SoccerCubit, SoccerState>(
      buildWhen: (_, state) {
        if (state is SoccerTodayFixturesLoading && !state.isTimerLoading) {
          return true;
        }
        return state is SoccerTodayFixturesLoaded ||
            state is SoccerTodayFixturesLoadFailure;
      },
      builder:
          (context, state) => switch (state) {
            SoccerTodayFixturesLoading() => const Padding(
              padding: EdgeInsets.symmetric(vertical: AppSpacing.xxxl),
              child:
                  ShimmerList(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                  ), // Use ShimmerList from Phase 2 instead of circular loading
            ),
            SoccerTodayFixturesLoaded(
              liveFixtures: final live,
              todayFixtures: final today,
            )
                when today.isNotEmpty =>
              StaggeredList(
                children: [
                  if (live.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
                      child: RepaintBoundary(child: ViewLiveFixtures(fixtures: live)),
                    ),
                  if (today.isNotEmpty) ViewDayFixtures(fixtures: today),
                ],
              ),
            SoccerTodayFixturesLoaded() =>
              const AppEmptyWidget().animate().fade().scale(),
            _ => const SizedBox.shrink(),
          },
    );
  }
}
