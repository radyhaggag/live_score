import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_score/src/core/extensions/nums.dart';
import 'package:live_score/src/features/soccer/presentation/widgets/block_dialog.dart';
import 'package:live_score/src/features/soccer/presentation/widgets/no_fixtures_today.dart';

import '../../../../core/error/response_status.dart';
import '../../../../core/widgets/center_indicator.dart';
import '../cubit/soccer_cubit.dart';
import '../cubit/soccer_state.dart';
import '../widgets/leagues_header.dart';
import '../widgets/view_fixtures.dart';

class SoccerScreen extends StatelessWidget {
  const SoccerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SoccerCubit, SoccerStates>(
      listener: (context, state) {
        if (state is SoccerLeaguesLoaded) {
          context.read<SoccerCubit>().getTodayFixtures();
        }
        if (state is SoccerFixturesLoadFailure &&
            state.message ==
                DataSource.networkConnectError.getFailure().message) {
          buildBlockAlert(context: context, message: state.message);
        }
        if (state is SoccerTodayFixturesLoadFailure &&
            state.message ==
                DataSource.networkConnectError.getFailure().message) {
          buildBlockAlert(context: context, message: state.message);
        }
        if (state is SoccerLeaguesLoadFailure &&
            state.message ==
                DataSource.networkConnectError.getFailure().message) {
          buildBlockAlert(context: context, message: state.message);
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
        SoccerCubit cubit = context.read<SoccerCubit>();
        if (state is SoccerLeaguesLoading) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
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
        return [
          SoccerTodayFixturesLoading,
          SoccerTodayFixturesLoaded,
          SoccerTodayFixturesLoadFailure,
        ].contains(state.runtimeType);
      },
      builder: (context, state) {
        if (state is SoccerTodayFixturesLoading) {
          return CenterIndicator();
        } else if (state is SoccerTodayFixturesLoaded) {
          if (state.todayFixtures.isNotEmpty) {
            return Column(
              children: [
                ViewLiveFixtures(fixtures: state.liveFixtures),
                SizedBox(height: 10.height),
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
