import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_score/src/core/extensions/nums.dart';
import 'package:live_score/src/features/soccer/presentation/widgets/error_dialog.dart';
import 'package:live_score/src/features/soccer/presentation/widgets/no_fixtures_today.dart';

import '../../../../core/widgets/center_indicator.dart';
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
    // Initial fetch of leagues and today's fixtures
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
    return BlocListener<SoccerCubit, SoccerStates>(
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
            onRetry: context.read<SoccerCubit>().getLeagues,
          );
        }
        if (state is SoccerTodayFixturesLoaded) {
          // Activate timer only when there are live fixtures
          if (state.liveFixtures.isNotEmpty) {
            _activateTimerFetching();
          } else {
            _timer?.cancel();
          }
        }
      },
      child: RefreshIndicator(
        onRefresh: context.read<SoccerCubit>().getTodayFixtures,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsetsDirectional.only(start: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const _LeaguesHeader(),
                const SizedBox(height: 20),
                const _ViewFixtures(),
                SizedBox(height: 20.height),
              ],
            ),
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
    return BlocBuilder<SoccerCubit, SoccerStates>(
      buildWhen: (context, state) {
        return [
          SoccerLeaguesLoading,
          SoccerLeaguesLoaded,
          SoccerLeaguesLoadFailure,
        ].contains(state.runtimeType);
      },
      builder: (context, state) {
        final SoccerCubit cubit = context.read<SoccerCubit>();
        if (state is SoccerLeaguesLoading) {
          return const Padding(
            padding: EdgeInsets.all(50.0),
            child: CenterIndicator(),
          );
        } else if (cubit.availableLeagues.isNotEmpty) {
          return CircleLeaguesHeader(leagues: cubit.availableLeagues);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
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
          return const CenterIndicator();
        } else if (state is SoccerTodayFixturesLoaded) {
          if (state.todayFixtures.isNotEmpty) {
            return Column(
              children: [
                if (state.liveFixtures.isNotEmpty) ...[
                  ViewLiveFixtures(fixtures: state.liveFixtures),
                  SizedBox(height: 10.height),
                ],
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
