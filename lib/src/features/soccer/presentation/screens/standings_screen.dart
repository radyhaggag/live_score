import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_score/src/core/extensions/nums.dart';
import 'package:live_score/src/core/utils/app_constants.dart';
import 'package:live_score/src/features/soccer/domain/use_cases/standings_usecase.dart';

import '../../../../core/utils/app_colors.dart';
import '../../domain/entities/team_rank.dart';
import '../cubit/soccer_cubit.dart';
import '../cubit/soccer_state.dart';
import '../widgets/leagues_header.dart';
import '../widgets/standings_item.dart';

class StandingsScreen extends StatefulWidget {
  const StandingsScreen({super.key});

  @override
  State<StandingsScreen> createState() => _StandingsScreenState();
}

class _StandingsScreenState extends State<StandingsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SoccerCubit>().getStandings(
        StandingsParams(leagueId: AppConstants.availableLeagues.first),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SoccerCubit>();

    return ListView(
      physics: const BouncingScrollPhysics(),

      children: [
        RectLeaguesHeader(leagues: cubit.availableLeagues, getFixtures: false),
        SizedBox(height: 5.height),
        BlocBuilder<SoccerCubit, SoccerStates>(
          buildWhen: (previous, current) {
            return [
              SoccerStandingsLoaded,
              SoccerStandingsLoading,
              SoccerStandingsLoadFailure,
            ].contains(current.runtimeType);
          },
          builder: (context, state) {
            if (state is SoccerStandingsLoading) {
              return const Center(
                child: LinearProgressIndicator(color: AppColors.deepOrange),
              );
            } else if (state is SoccerStandingsLoaded) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const StandingsHeaders(),
                    SizedBox(height: 10.height),
                    ...List.generate(state.standings.standings.length, (
                      teamIndex,
                    ) {
                      TeamRank team = state.standings.standings[teamIndex];
                      return StandingsItem(
                        teamRank: team,
                        totalTeams: state.standings.standings.length,
                      );
                    }),
                    SizedBox(height: 10.height),
                  ],
                ),
              );
            } else {
              return SizedBox();
            }
          },
        ),
      ],
    );
  }
}
