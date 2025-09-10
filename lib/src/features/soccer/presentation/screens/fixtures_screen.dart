import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_score/src/core/extensions/color.dart';
import 'package:live_score/src/core/extensions/nums.dart';
import 'package:live_score/src/core/utils/app_colors.dart';

import '../cubit/soccer_cubit.dart';
import '../cubit/soccer_state.dart';
import '../widgets/grouped_fixtures_list.dart';
import '../widgets/leagues_header.dart';
import '../widgets/no_fixtures_today.dart';

class FixturesScreen extends StatefulWidget {
  const FixturesScreen({super.key, this.competitionId});

  final int? competitionId;

  @override
  State<FixturesScreen> createState() => _FixturesScreenState();
}

class _FixturesScreenState extends State<FixturesScreen> {
  int? initialSelectedLeagueId;

  @override
  void initState() {
    super.initState();
    initialSelectedLeagueId = widget.competitionId;
    final availableLeagues = context.read<SoccerCubit>().availableLeagues;
    if (availableLeagues.isEmpty) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (initialSelectedLeagueId == null) {
        context.read<SoccerCubit>().getTodayFixtures();
      } else {
        context.read<SoccerCubit>().getCurrentRoundFixtures(
          competitionId: initialSelectedLeagueId!,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SoccerCubit cubit = context.read<SoccerCubit>();
    return BlocBuilder<SoccerCubit, SoccerStates>(
      buildWhen: (previous, current) {
        return [
          SoccerTodayFixturesLoading,
          SoccerTodayFixturesLoadFailure,
          SoccerTodayFixturesLoaded,
          SoccerCurrentRoundFixturesLoading,
          SoccerCurrentRoundFixturesLoadFailure,
          SoccerCurrentRoundFixturesLoaded,
        ].contains(current.runtimeType);
      },
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RectLeaguesHeader(
              leagues: cubit.availableLeagues,
              getFixtures: true,
              initialSelectedLeagueId: initialSelectedLeagueId,
              prefixIcon: _getPrefixIcon(),
              onPrefixIconTap: context.read<SoccerCubit>().getTodayFixtures,
            ),
            SizedBox(height: 10.height),
            if (state is SoccerCurrentRoundFixturesLoading ||
                state is SoccerTodayFixturesLoading)
              const LinearProgressIndicator()
            else if (state is SoccerCurrentRoundFixturesLoaded &&
                state.fixtures.isNotEmpty)
              Expanded(child: GroupedFixturesList(fixtures: state.fixtures))
            else if (state is SoccerTodayFixturesLoaded &&
                state.todayFixtures.isNotEmpty)
              Expanded(
                child: GroupedFixturesList(fixtures: state.todayFixtures),
              )
            else if (state is SoccerCurrentRoundFixturesLoaded &&
                state.fixtures.isEmpty)
              NoFixturesView()
            else if (state is SoccerTodayFixturesLoaded &&
                state.todayFixtures.isEmpty)
              NoFixturesView()
            else
              const SizedBox.shrink(),
          ],
        );
      },
    );
  }

  Widget _getPrefixIcon() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.radius),
        gradient: AppColors.blueGradient,
        border: Border.all(color: AppColors.white, width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacitySafe(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: const Icon(Icons.public, color: AppColors.white),
    );
  }
}
