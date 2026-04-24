import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_score/src/core/constants/app_spacing.dart';
import 'package:live_score/src/core/extensions/color.dart';
import 'package:live_score/src/core/extensions/context_ext.dart';
import 'package:live_score/src/core/extensions/responsive_size.dart';
import 'package:live_score/src/core/widgets/app_error_dialog.dart';
import 'package:live_score/src/core/widgets/app_loading.dart';

import '../../../../core/widgets/app_empty.dart';
import '../../../../core/widgets/leagues_header.dart';
import '../../../../core/widgets/settings_language_listener.dart';
import '../cubit/leagues/leagues_cubit.dart';
import '../cubit/soccer/soccer_cubit.dart';
import '../cubit/soccer/soccer_state.dart';
import '../widgets/grouped_fixtures_list.dart';

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
      _fetchFixtures();
    });
  }

  void _fetchFixtures() {
    final cubit = context.read<SoccerCubit>();
    if (initialSelectedLeagueId == null) {
      cubit.getTodayFixtures();
    } else {
      cubit.getCurrentRoundFixtures(competitionId: initialSelectedLeagueId!);
    }
  }

  void _onLanguageChanged(BuildContext context, _) {
    context.read<LeaguesCubit>().getLeagues(forceRefresh: true);
    _fetchFixtures();
  }

  void _onSoccerError(BuildContext context, SoccerState state) {
    if (state is SoccerTodayFixturesLoadFailure) {
      AppErrorDialog.show(
        context: context,
        message: state.message,
        onRetry: context.read<SoccerCubit>().getTodayFixtures,
      );
    } else if (state is SoccerCurrentRoundFixturesLoadFailure) {
      AppErrorDialog.show(
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
  }

  bool _shouldRebuild(SoccerState previous, SoccerState current) {
    return current is SoccerTodayFixturesLoading ||
        current is SoccerTodayFixturesLoadFailure ||
        current is SoccerTodayFixturesLoaded ||
        current is SoccerCurrentRoundFixturesLoading ||
        current is SoccerCurrentRoundFixturesLoadFailure ||
        current is SoccerCurrentRoundFixturesLoaded;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        SettingsLanguageListener(onLanguageChanged: _onLanguageChanged),
        BlocListener<SoccerCubit, SoccerState>(listener: _onSoccerError),
      ],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const _FixturesHeader(),
          const SizedBox(height: AppSpacing.m),
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
      SoccerCurrentRoundFixturesLoading() ||
      SoccerTodayFixturesLoading() => const ShimmerList(itemCount: 8),
      SoccerCurrentRoundFixturesLoaded(fixtures: final f) when f.isNotEmpty =>
        GroupedFixturesList(fixtures: f, showLeagueLogo: true),
      SoccerTodayFixturesLoaded(todayFixtures: final f) when f.isNotEmpty =>
        GroupedFixturesList(fixtures: f, showLeagueLogo: true),
      SoccerCurrentRoundFixturesLoadFailure() ||
      SoccerTodayFixturesLoadFailure() => Center(
        child: AppEmptyWidget(message: context.l10n.errorLoadFixtures),
      ),
      _ => const Center(child: AppEmptyWidget()),
    };
  }
}

class _FixturesHeader extends StatelessWidget {
  const _FixturesHeader();

  @override
  Widget build(BuildContext context) {
    final leagues = context.select(
      (LeaguesCubit cubit) => cubit.availableLeagues,
    );
    final screen = context.findAncestorStateOfType<_FixturesScreenState>();

    return RectLeaguesHeader(
      leagues: leagues,
      onLeagueTap: (league) {
        context.read<SoccerCubit>().getCurrentRoundFixtures(competitionId: league.id);
      },
      initialSelectedLeagueId: screen?.initialSelectedLeagueId,
      prefixIcon: const _AllLeaguesPrefixIcon(),
      onPrefixIconTap: context.read<SoccerCubit>().getTodayFixtures,
    );
  }
}

class _AllLeaguesPrefixIcon extends StatelessWidget {
  const _AllLeaguesPrefixIcon();

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: context.l10n.allLeaguesTooltip,
      child: Container(
        height: 45.h,
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: AppSpacing.m,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          gradient: context.colorsExt.blueGradient,
          border: Border.all(color: context.colorsExt.white, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacitySafe(0.2),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.tune_rounded,
              color: context.colorsExt.white,
              size: 18.sp,
            ),
            const SizedBox(width: AppSpacing.xs),
            Text(
              context.l10n.all,
              style: TextStyle(
                color: context.colorsExt.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
