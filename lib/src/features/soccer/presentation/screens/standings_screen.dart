import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_score/src/core/constants/app_spacing.dart';
import 'package:live_score/src/core/extensions/color.dart';
import 'package:live_score/src/core/extensions/context_ext.dart';
import 'package:live_score/src/core/utils/app_animations.dart';
import 'package:live_score/src/core/widgets/app_error_dialog.dart';
import 'package:live_score/src/features/soccer/domain/use_cases/standings_usecase.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/app_empty.dart';
import '../../../../core/widgets/settings_language_listener.dart';
import '../cubit/leagues/leagues_cubit.dart';
import '../cubit/soccer/soccer_cubit.dart';
import '../cubit/soccer/soccer_state.dart';
import '../widgets/standings_shimmer.dart';
import '../widgets/standings_table.dart';

class StandingsScreen extends StatefulWidget {
  const StandingsScreen({super.key, this.competitionId});

  final int? competitionId;

  @override
  State<StandingsScreen> createState() => _StandingsScreenState();
}

class _StandingsScreenState extends State<StandingsScreen> {
  late final int _leagueId;
  late final ScrollController _groupedHorizontalController;

  @override
  void initState() {
    super.initState();
    _leagueId = widget.competitionId ?? AppConstants.defaultLeagueId;
    _groupedHorizontalController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchStandings();
    });
  }

  @override
  void dispose() {
    _groupedHorizontalController.dispose();
    super.dispose();
  }

  void _fetchStandings() {
    context.read<SoccerCubit>().getStandings(
      StandingsParams(leagueId: _leagueId),
    );
  }

  void _onLanguageChanged(BuildContext context, _) {
    context.read<LeaguesCubit>().getLeagues(forceRefresh: true);
    _fetchStandings();
  }

  void _onSoccerError(BuildContext context, SoccerState state) {
    if (state is SoccerStandingsLoadFailure) {
      AppErrorDialog.show(
        context: context,
        message: state.message,
        onRetry: _fetchStandings,
      );
    }
  }

  bool _shouldRebuild(SoccerState previous, SoccerState current) {
    return current is SoccerStandingsLoaded ||
        current is SoccerStandingsLoading ||
        current is SoccerStandingsLoadFailure;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        SettingsLanguageListener(onLanguageChanged: _onLanguageChanged),
        BlocListener<SoccerCubit, SoccerState>(listener: _onSoccerError),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StandingsHeader(leagueId: _leagueId),
          const SizedBox(height: AppSpacing.s),
          Expanded(
            child: BlocBuilder<SoccerCubit, SoccerState>(
              buildWhen: _shouldRebuild,
              builder: (context, state) => _buildBody(context, state),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, SoccerState state) {
    return switch (state) {
      SoccerStandingsLoading() => const StandingsShimmer(itemCount: 15),
      SoccerStandingsLoaded() && final s => _buildStandingsContent(context, s),
      _ => Center(
        child: AppEmptyWidget(message: context.l10n.errorLoadStandings),
      ),
    };
  }

  Widget _buildStandingsContent(
    BuildContext context,
    SoccerStandingsLoaded state,
  ) {
    if (state.standings.standings.isEmpty) {
      return Center(
        child: AppEmptyWidget(message: context.l10n.noStandingsYet),
      );
    }

    final groups = state.standings.groups ?? [];

    if (groups.isEmpty) {
      return ScrollableStandingsTable(
        teams: state.standings.standings,
        totalTeams: state.standings.standings.length,
        bottomPadding: 120,
      );
    }

    return SingleChildScrollView(
      controller: _groupedHorizontalController,
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: 680, // Match minWidth in StandingsTable
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 120),
          itemCount: groups.length,
          itemBuilder: (context, groupIndex) {
            final group = groups[groupIndex];
            final groupTeams =
                state.standings.standings
                    .where((team) => team.groupNum == group.number)
                    .toList();

            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.xl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.l,
                      vertical: AppSpacing.m,
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.m,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        gradient: context.colorsExt.liveGradient,
                        borderRadius: BorderRadius.circular(999),
                        boxShadow: [
                          BoxShadow(
                            color: context.colorsExt.lightRed.withOpacitySafe(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        group.name.toUpperCase(),
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: context.colorsExt.white,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                  FadeSlideIn(
                    delay: Duration(milliseconds: 50 * groupIndex),
                    child: StandingsTable(
                      teams: groupTeams,
                      totalTeams: groupTeams.length,
                      isGrouped: true,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
