import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_score/src/core/constants/app_spacing.dart';
import 'package:live_score/src/core/extensions/color.dart';
import 'package:live_score/src/core/extensions/context_ext.dart';
import 'package:live_score/src/core/widgets/app_error_dialog.dart';
import 'package:live_score/src/core/widgets/app_loading.dart';

import '../../../../core/widgets/app_empty.dart';
import '../../../../core/widgets/settings_language_listener.dart';
import '../cubit/leagues_cubit.dart';
import '../cubit/soccer_cubit.dart';
import '../cubit/soccer_state.dart';
import '../widgets/grouped_fixtures_list.dart';
import '../widgets/leagues_header.dart';

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
        SettingsLanguageListener(
          onLanguageChanged: (context, state) {
            final soccerCubit = context.read<SoccerCubit>();
            context.read<LeaguesCubit>().getLeagues(forceRefresh: true);
            if (initialSelectedLeagueId == null) {
              soccerCubit.getTodayFixtures();
            } else {
              soccerCubit.getCurrentRoundFixtures(
                competitionId: initialSelectedLeagueId!,
              );
            }
          },
        ),
        BlocListener<SoccerCubit, SoccerState>(
          listener: (context, state) {
            if (state is SoccerTodayFixturesLoadFailure) {
              AppErrorDialog.show(
                context: context,
                message: state.message,
                onRetry: context.read<SoccerCubit>().getTodayFixtures,
              );
            }
            if (state is SoccerCurrentRoundFixturesLoadFailure) {
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
          },
        ),
      ],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const _FixturesHeader(),
          const SizedBox(height: AppSpacing.m),
          Expanded(
            child: BlocBuilder<SoccerCubit, SoccerState>(
              buildWhen: (previous, current) {
                return current is SoccerTodayFixturesLoading ||
                    current is SoccerTodayFixturesLoadFailure ||
                    current is SoccerTodayFixturesLoaded ||
                    current is SoccerCurrentRoundFixturesLoading ||
                    current is SoccerCurrentRoundFixturesLoadFailure ||
                    current is SoccerCurrentRoundFixturesLoaded;
              },
              builder: (context, state) {
                if (state is SoccerCurrentRoundFixturesLoading ||
                    state is SoccerTodayFixturesLoading) {
                  return const Align(
                    alignment: Alignment.topCenter,
                    child: AppLoadingIndicator(isLinear: true),
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
                  return Center(
                    child: AppEmptyWidget(
                      message: context.l10n.errorLoadFixtures,
                    ),
                  );
                }

                return const Center(child: AppEmptyWidget());
              },
            ),
          ),
        ],
      ),
    );
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
      getFixtures: true,
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
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
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
            Icon(Icons.tune_rounded, color: context.colorsExt.white, size: 18),
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
