import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_score/src/core/constants/app_spacing.dart';

import '../../../../core/widgets/leagues_header.dart';
import '../../domain/entities/team_rank.dart';
import '../../domain/use_cases/standings_usecase.dart';
import '../cubit/leagues/leagues_cubit.dart';
import '../cubit/soccer/soccer_cubit.dart';
import '../widgets/standings_headers.dart';
import '../widgets/standings_item.dart';

/// Header with league selector for the standings screen.
class StandingsHeader extends StatelessWidget {
  const StandingsHeader({super.key, required this.leagueId});

  final int leagueId;

  @override
  Widget build(BuildContext context) {
    final leagues = context.select(
      (LeaguesCubit cubit) => cubit.availableLeagues,
    );
    return RectLeaguesHeader(
      leagues: leagues,
      onLeagueTap: (league) {
        context.read<SoccerCubit>().getStandings(StandingsParams(leagueId: league.id));
      },
      initialSelectedLeagueId: leagueId,
    );
  }
}

/// Grouped standings table (used in cup/group phase competitions).
class StandingsTable extends StatelessWidget {
  const StandingsTable({
    super.key,
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

        return Scrollbar(
          thumbVisibility: true,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              width: tableWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const StandingsHeaders(),
                  const SizedBox(height: AppSpacing.s),
                  ...List.generate(teams.length, (teamIndex) {
                    final team = teams[teamIndex];
                    return StandingsItem(
                      teamRank: team,
                      totalTeams: totalTeams,
                      isGrouped: isGrouped,
                      index: teamIndex,
                    );
                  }),
                  const SizedBox(height: AppSpacing.s),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Full standings table with vertical + horizontal scroll (league phase).
class ScrollableStandingsTable extends StatelessWidget {
  const ScrollableStandingsTable({
    super.key,
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

        return Scrollbar(
          thumbVisibility: true,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              width: tableWidth,
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _StandingsHeaderDelegate(),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.s)),
                  SliverList.builder(
                    itemCount: teams.length,
                    itemBuilder: (context, index) {
                      final team = teams[index];
                      return StandingsItem(
                        teamRank: team,
                        totalTeams: totalTeams,
                        index: index,
                      );
                    },
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.s)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _StandingsHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return const Material(
      color: Colors.transparent, // Let the headers widget handle the styling
      child: StandingsHeaders(),
    );
  }

  @override
  double get maxExtent => 44.0; // Estimate height based on StandingsHeaders padding/text

  @override
  double get minExtent => 44.0;

  @override
  bool shouldRebuild(covariant _StandingsHeaderDelegate oldDelegate) {
    return false;
  }
}
