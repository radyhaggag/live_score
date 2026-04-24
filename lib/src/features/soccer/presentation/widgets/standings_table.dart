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
class StandingsTable extends StatefulWidget {
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
  State<StandingsTable> createState() => _StandingsTableState();
}

class _StandingsTableState extends State<StandingsTable> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            width: tableWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const StandingsHeaders(),
                const SizedBox(height: AppSpacing.s),
                ...List.generate(widget.teams.length, (teamIndex) {
                  final team = widget.teams[teamIndex];
                  return StandingsItem(
                    teamRank: team,
                    totalTeams: widget.totalTeams,
                    isGrouped: widget.isGrouped,
                    index: teamIndex,
                  );
                }),
                const SizedBox(height: AppSpacing.s),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Full standings table with vertical + horizontal scroll (league phase).
class ScrollableStandingsTable extends StatefulWidget {
  const ScrollableStandingsTable({
    super.key,
    required this.teams,
    required this.totalTeams,
    this.bottomPadding = 0,
  });

  final List<TeamRank> teams;
  final int totalTeams;
  final double bottomPadding;

  @override
  State<ScrollableStandingsTable> createState() => _ScrollableStandingsTableState();
}

class _ScrollableStandingsTableState extends State<ScrollableStandingsTable> {
  late final ScrollController _horizontalController;

  @override
  void initState() {
    super.initState();
    _horizontalController = ScrollController();
  }

  @override
  void dispose() {
    _horizontalController.dispose();
    super.dispose();
  }

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
          controller: _horizontalController,
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
                  itemCount: widget.teams.length,
                  itemBuilder: (context, index) {
                    final team = widget.teams[index];
                    return StandingsItem(
                      teamRank: team,
                      totalTeams: widget.totalTeams,
                      index: index,
                    );
                  },
                ),
                SliverToBoxAdapter(child: SizedBox(height: widget.bottomPadding + AppSpacing.s)),
              ],
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
