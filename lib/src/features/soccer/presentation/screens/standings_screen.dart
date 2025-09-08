import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_size.dart';
import '../../domain/entities/team_rank.dart';
import '../cubit/soccer_cubit.dart';
import '../cubit/soccer_state.dart';
import '../widgets/leagues_header.dart';
import '../widgets/standings_item.dart';

class StandingsScreen extends StatelessWidget {
  const StandingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SoccerCubit>();

    return ListView(
      physics: const BouncingScrollPhysics(),

      children: [
        CircleLeaguesHeader(leagues: cubit.filteredLeagues, getFixtures: false),
        const SizedBox(height: AppSize.s5),
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
                    const SizedBox(height: AppSize.s10),
                    ...List.generate(state.standings.standings.length, (
                      teamIndex,
                    ) {
                      TeamRank team = state.standings.standings[teamIndex];
                      return StandingsItem(teamRank: team);
                    }),
                    const SizedBox(height: AppSize.s10),
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
