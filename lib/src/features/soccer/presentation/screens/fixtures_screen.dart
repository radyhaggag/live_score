import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_score/src/core/extensions/color.dart';
import 'package:live_score/src/core/utils/app_colors.dart';
import 'package:live_score/src/features/soccer/presentation/widgets/error_dialog.dart';

import '../../../settings/presentation/cubit/settings_cubit.dart';
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
    return MultiBlocListener(
      listeners: [
        BlocListener<SettingsCubit, SettingsState>(
          listenWhen:
              (previous, current) => previous.language != current.language,
          listener: (context, state) {
            final soccerCubit = context.read<SoccerCubit>();
            soccerCubit.getLeagues(forceRefresh: true);
            if (initialSelectedLeagueId == null) {
              soccerCubit.getTodayFixtures();
            } else {
              soccerCubit.getCurrentRoundFixtures(
                competitionId: initialSelectedLeagueId!,
              );
            }
          },
        ),
        BlocListener<SoccerCubit, SoccerStates>(
          listener: (context, state) {
            if (state is SoccerTodayFixturesLoadFailure) {
              ErrorDialog.show(
                context: context,
                message: state.message,
                onRetry: context.read<SoccerCubit>().getTodayFixtures,
              );
            }
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
          },
        ),
      ],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const _FixturesHeader(),
          const SizedBox(height: 12),
          Expanded(
            child: BlocBuilder<SoccerCubit, SoccerStates>(
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
                if (state is SoccerCurrentRoundFixturesLoading ||
                    state is SoccerTodayFixturesLoading) {
                  return const Align(
                    alignment: Alignment.topCenter,
                    child: LinearProgressIndicator(),
                  );
                }

                if (state is SoccerCurrentRoundFixturesLoaded &&
                    state.fixtures.isNotEmpty) {
                  return GroupedFixturesList(
                    fixtures: state.fixtures,
                    showLeagueLogo: true,
                  );
                }

                if (state is SoccerTodayFixturesLoaded &&
                    state.todayFixtures.isNotEmpty) {
                  return GroupedFixturesList(
                    fixtures: state.todayFixtures,
                    showLeagueLogo: true,
                  );
                }

                if (state is SoccerCurrentRoundFixturesLoadFailure ||
                    state is SoccerTodayFixturesLoadFailure) {
                  return const Center(
                    child: NoFixturesView(
                      message: 'Unable to load fixtures right now.',
                    ),
                  );
                }

                return const Center(child: NoFixturesView());
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _getPrefixIcon() {
    return Tooltip(
      message: 'All leagues',
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: AppColors.blueGradient,
          border: Border.all(color: AppColors.white, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacitySafe(0.2),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.tune_rounded, color: AppColors.white, size: 18),
            SizedBox(width: 6),
            Text(
              'All',
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FixturesHeader extends StatelessWidget {
  const _FixturesHeader();

  @override
  Widget build(BuildContext context) {
    final leagues = context.select(
      (SoccerCubit cubit) => cubit.availableLeagues,
    );
    final screen = context.findAncestorStateOfType<_FixturesScreenState>();

    return RectLeaguesHeader(
      leagues: leagues,
      getFixtures: true,
      initialSelectedLeagueId: screen?.initialSelectedLeagueId,
      prefixIcon: screen?._getPrefixIcon(),
      onPrefixIconTap: context.read<SoccerCubit>().getTodayFixtures,
    );
  }
}
