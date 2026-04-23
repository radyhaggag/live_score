import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_score/src/core/extensions/context_ext.dart';
import 'package:live_score/src/core/widgets/app_loading.dart';
import 'package:live_score/src/features/soccer/domain/use_cases/standings_usecase.dart';
import 'package:live_score/src/core/widgets/app_error_dialog.dart';

import '../../../../core/constants/app_constants.dart';
import '../cubit/leagues_cubit.dart';
import '../cubit/soccer_cubit.dart';
import '../cubit/soccer_state.dart';
import '../../../../core/widgets/app_empty.dart';
import '../../../../core/widgets/settings_language_listener.dart';
import '../widgets/standings_table.dart';
import 'package:live_score/src/core/constants/app_spacing.dart';

class StandingsScreen extends StatefulWidget {
  const StandingsScreen({super.key, this.competitionId});

  final int? competitionId;

  @override
  State<StandingsScreen> createState() => _StandingsScreenState();
}

class _StandingsScreenState extends State<StandingsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SoccerCubit>().getStandings(
        StandingsParams(
          leagueId: widget.competitionId ?? AppConstants.defaultLeagueId,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final leagueId = widget.competitionId ?? AppConstants.defaultLeagueId;

    return MultiBlocListener(
      listeners: [
        SettingsLanguageListener(
          onLanguageChanged: (context, state) {
            final soccerCubit = context.read<SoccerCubit>();
            context.read<LeaguesCubit>().getLeagues(forceRefresh: true);
            soccerCubit.getStandings(StandingsParams(leagueId: leagueId));
          },
        ),
        BlocListener<SoccerCubit, SoccerState>(
          listener: (context, state) {
            if (state is SoccerStandingsLoadFailure) {
              AppErrorDialog.show(
                context: context,
                message: state.message,
                onRetry: () {
                  context.read<SoccerCubit>().getStandings(
                    StandingsParams(leagueId: leagueId),
                  );
                },
              );
            }
          },
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StandingsHeader(leagueId: leagueId),
          const SizedBox(height: AppSpacing.s),
          Expanded(
            child: BlocBuilder<SoccerCubit, SoccerState>(
              buildWhen: (previous, current) {
                return current is SoccerStandingsLoaded ||
                    current is SoccerStandingsLoading ||
                    current is SoccerStandingsLoadFailure;
              },
              builder: (context, state) {
                if (state is SoccerStandingsLoading) {
                  return const Align(
                    alignment: Alignment.topCenter,
                    child: AppLoadingIndicator(isLinear: true),
                  );
                }

                if (state is SoccerStandingsLoaded) {
                  final groups = state.standings.groups ?? [];
                  if (state.standings.standings.isEmpty) {
                    return Center(
                      child: AppEmptyWidget(
                        message: context.l10n.noStandingsYet,
                      ),
                    );
                  }

                  if (groups.isEmpty) {
                    return ScrollableStandingsTable(
                      teams: state.standings.standings,
                      totalTeams: state.standings.standings.length,
                    );
                  }

                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: groups.length,
                    itemBuilder: (context, groupIndex) {
                      final group = groups[groupIndex];
                      final groupTeams =
                          state.standings.standings
                              .where((team) => team.groupNum == group.number)
                              .toList();

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 10,
                              ),
                              child: Text(
                                group.name,
                                style: Theme.of(
                                  context,
                                ).textTheme.titleMedium?.copyWith(
                                  color: context.colorsExt.lightRed,
                                ),
                              ),
                            ),
                            StandingsTable(
                              teams: groupTeams,
                              totalTeams: groupTeams.length,
                              isGrouped: true,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }

                return Center(
                  child: AppEmptyWidget(
                    message: context.l10n.errorLoadStandings,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
