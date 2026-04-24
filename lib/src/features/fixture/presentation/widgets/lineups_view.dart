import 'package:flutter/material.dart';
import 'package:live_score/src/core/constants/app_spacing.dart';
import 'package:live_score/src/core/extensions/responsive_size.dart';
import 'package:live_score/src/core/domain/entities/teams.dart';
import 'package:live_score/src/core/extensions/strings.dart';
import 'package:live_score/src/features/fixture/domain/entities/fixture_details.dart';

import '../../../../core/extensions/context_ext.dart';
import '../../../../core/theme/app_fonts.dart';
import '../../../../core/widgets/app_empty.dart';
import '../../../../core/widgets/custom_image.dart';
import 'pitch_painter.dart';
import 'teams_lineups.dart';

/// Displays the full-pitch lineup for both teams.
///
/// Shows team headers above and below the pitch with formation strings,
/// and renders player markers at their respective field positions.
class LineupsView extends StatelessWidget {
  final FixtureDetails? fixtureDetails;
  final Color? color;

  const LineupsView({super.key, required this.fixtureDetails, this.color});

  @override
  Widget build(BuildContext context) {
    final homeTeam = fixtureDetails?.fixture.teams.home;
    final awayTeam = fixtureDetails?.fixture.teams.away;
    final hasLineups =
        (homeTeam?.lineup?.formation ?? '').isNotEmpty &&
        (awayTeam?.lineup?.formation ?? '').isNotEmpty;

    if (!hasLineups) {
      return AppEmptyWidget(
        icon: Icons.people,
        message: context.l10n.noLineups,
        color: color,
      );
    }

    return Column(
      children: [
        _LineupTeamHeader(team: homeTeam!),
        SizedBox(
          width: double.infinity,
          height: 560.h,
          child: CustomPaint(
            painter: PitchPainter(
              pitchColor: context.colorsExt.darkGreen,
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.only(
                start: AppSpacing.m,
                end: AppSpacing.m,
                top: AppSpacing.xl,
              ),
              child: TeamsLineups(fixtureDetails: fixtureDetails!),
            ),
          ),
        ),
        _LineupTeamHeader(team: awayTeam!),
      ],
    );
  }
}

/// Team header row showing logo, name, and formation string.
class _LineupTeamHeader extends StatelessWidget {
  const _LineupTeamHeader({required this.team});

  final Team team;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colorsExt.darkGreen,
      padding: const EdgeInsetsDirectional.all(AppSpacing.s),
      child: Row(
        children: [
          CustomImage(width: 35.w, height: 35.h, imageUrl: team.logo),
          const SizedBox(width: AppSpacing.s),
          Expanded(
            child: Text(
              team.name.teamName,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: context.colorsExt.white),
            ),
          ),
          Text(
            team.lineup?.formation ?? '',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: context.colorsExt.white,
              fontWeight: FontWeights.semiBold,
            ),
          ),
        ],
      ),
    );
  }
}
