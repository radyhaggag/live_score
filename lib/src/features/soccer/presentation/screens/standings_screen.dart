import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_score/src/core/constants/app_spacing.dart';
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

class StandingsScreen extends StatefulWidget {
  const StandingsScreen({super.key, this.competitionId});

  final int? competitionId;

  @override
  State<StandingsScreen> createState() => _StandingsScreenState();
}

class _StandingsScreenState extends State<StandingsScreen> {
  late final int _leagueId;

  @override
  void initState() {
    super.initState();
    _leagueId = widget.competitionId ?? AppConstants.defaultLeagueId;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchStandings();
    });
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
      SoccerStandingsLoading() => const Align(
        alignment: Alignment.topCenter,
        child: AppLoadingIndicator(isLinear: true),
      ),
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
          padding: const EdgeInsets.only(bottom: AppSpacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.l,
                  vertical: AppSpacing.m,
                ),
                child: Text(
                  group.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
}
