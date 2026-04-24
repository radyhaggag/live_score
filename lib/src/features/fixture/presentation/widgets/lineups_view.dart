import 'package:flutter/material.dart';
import 'package:live_score/src/core/constants/app_spacing.dart';
import 'package:live_score/src/core/domain/entities/teams.dart';
import 'package:live_score/src/core/extensions/color.dart';
import 'package:live_score/src/core/extensions/responsive_size.dart';
import 'package:live_score/src/core/extensions/strings.dart';
import 'package:live_score/src/features/fixture/domain/entities/fixture_details.dart';

import '../../../../core/extensions/context_ext.dart';
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

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.m,
        vertical: AppSpacing.l,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.1),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            _LineupTeamHeader(
              team: homeTeam!,
              isTop: true,
              teamColor:
                  ('#${homeTeam.color ?? homeTeam.awayColor ?? "1E5631"}')
                      .toColor,
            ),
            SizedBox(
              height: 640.h,
              width: double.infinity,
              child: CustomPaint(
                painter: PitchPainter(pitchColor: context.colorsExt.darkGreen),
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
            _LineupTeamHeader(
              team: awayTeam!,
              isTop: false,
              teamColor:
                  ('#${awayTeam.color ?? awayTeam.awayColor ?? "FFFFFF"}')
                      .toColor,
            ),
          ],
        ),
      ),
    );
  }
}

/// Team header row showing logo, name, and formation string.
class _LineupTeamHeader extends StatelessWidget {
  const _LineupTeamHeader({
    required this.team,
    required this.isTop,
    required this.teamColor,
  });

  final Team team;
  final bool isTop;
  final Color teamColor;

  @override
  Widget build(BuildContext context) {
    final textColor = _contrastColor(teamColor);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [teamColor.withValues(alpha: 0.9), teamColor],
          begin: isTop ? Alignment.topCenter : Alignment.bottomCenter,
          end: isTop ? Alignment.bottomCenter : Alignment.topCenter,
        ),
      ),
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.m,
        vertical: AppSpacing.s,
      ),
      child: Row(
        children: [
          CustomImage(width: 24, height: 24, imageUrl: team.logo),
          const SizedBox(width: AppSpacing.s),
          Expanded(
            child: Text(
              team.name.teamName,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: textColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              team.lineup?.formation ?? '',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _contrastColor(Color backgroundColor) {
    final double luminance =
        (0.299 * backgroundColor.r * 255.0 +
            0.587 * backgroundColor.g * 255.0 +
            0.114 * backgroundColor.b * 255.0) /
        255;
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}
