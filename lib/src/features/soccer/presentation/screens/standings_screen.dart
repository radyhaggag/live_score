import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_score/src/core/utils/app_colors.dart';
import 'package:live_score/src/features/soccer/domain/use_cases/standings_usecase.dart';
import 'package:live_score/src/features/soccer/presentation/widgets/error_dialog.dart';

import '../../../settings/presentation/cubit/settings_cubit.dart';
import '../../domain/entities/team_rank.dart';
import '../../../../core/utils/app_constants.dart';
import '../cubit/soccer_cubit.dart';
import '../cubit/soccer_state.dart';
import '../widgets/leagues_header.dart';
import '../widgets/no_fixtures_today.dart';
import '../widgets/standings_item.dart';

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
        BlocListener<SettingsCubit, SettingsState>(
          listenWhen:
              (previous, current) => previous.language != current.language,
          listener: (context, state) {
            final soccerCubit = context.read<SoccerCubit>();
            soccerCubit.getLeagues(forceRefresh: true);
            soccerCubit.getStandings(StandingsParams(leagueId: leagueId));
          },
        ),
        BlocListener<SoccerCubit, SoccerStates>(
          listener: (context, state) {
            if (state is SoccerStandingsLoadFailure) {
              ErrorDialog.show(
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
          _StandingsHeader(leagueId: leagueId),
          const SizedBox(height: 8),
          Expanded(
            child: BlocBuilder<SoccerCubit, SoccerStates>(
              buildWhen: (previous, current) {
                return [
                  SoccerStandingsLoaded,
                  SoccerStandingsLoading,
                  SoccerStandingsLoadFailure,
                ].contains(current.runtimeType);
              },
              builder: (context, state) {
                if (state is SoccerStandingsLoading) {
                  return const Align(
                    alignment: Alignment.topCenter,
                    child: LinearProgressIndicator(color: AppColors.deepOrange),
                  );
                } else if (state is SoccerStandingsLoaded) {
                  final groups = state.standings.groups ?? [];
                  if (state.standings.standings.isEmpty) {
                    return const Center(
                      child: NoFixturesView(
                        message: 'No standings available yet.',
                      ),
                    );
                  }

                  if (groups.isEmpty) {
                    return _ScrollableStandingsTable(
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
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(color: AppColors.lightRed),
                              ),
                            ),
                            _StandingsTable(
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

                return const Center(
                  child: NoFixturesView(
                    message: 'Unable to load standings right now.',
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

class _StandingsHeader extends StatelessWidget {
  const _StandingsHeader({required this.leagueId});

  final int leagueId;

  @override
  Widget build(BuildContext context) {
    final leagues = context.select(
      (SoccerCubit cubit) => cubit.availableLeagues,
    );
    return RectLeaguesHeader(
      leagues: leagues,
      getFixtures: false,
      initialSelectedLeagueId: leagueId,
    );
  }
}

class _StandingsTable extends StatelessWidget {
  const _StandingsTable({
    required this.teams,
    required this.totalTeams,
    this.isGrouped = false,
  });

  final List<TeamRank> teams;
  final int totalTeams;
  final bool isGrouped;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const minWidth = 680.0;
        final tableWidth =
            constraints.maxWidth.isFinite && constraints.maxWidth > minWidth
                ? constraints.maxWidth
                : minWidth;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            width: tableWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const StandingsHeaders(),
                const SizedBox(height: 10),
                ...List.generate(teams.length, (teamIndex) {
                  final team = teams[teamIndex];
                  return StandingsItem(
                    teamRank: team,
                    totalTeams: totalTeams,
                    isGrouped: isGrouped,
                  );
                }),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ScrollableStandingsTable extends StatelessWidget {
  const _ScrollableStandingsTable({
    required this.teams,
    required this.totalTeams,
  });

  final List<TeamRank> teams;
  final int totalTeams;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const minWidth = 680.0;
        final tableWidth =
            constraints.maxWidth.isFinite && constraints.maxWidth > minWidth
                ? constraints.maxWidth
                : minWidth;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            width: tableWidth,
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                const SliverToBoxAdapter(child: StandingsHeaders()),
                const SliverToBoxAdapter(child: SizedBox(height: 10)),
                SliverList.builder(
                  itemCount: teams.length,
                  itemBuilder: (context, index) {
                    final team = teams[index];
                    return StandingsItem(
                      teamRank: team,
                      totalTeams: totalTeams,
                    );
                  },
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 10)),
              ],
            ),
          ),
        );
      },
    );
  }
}
