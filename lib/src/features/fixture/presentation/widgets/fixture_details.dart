import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:live_score/src/core/extensions/color.dart';
import 'package:live_score/src/core/extensions/fixture.dart';
import 'package:live_score/src/core/extensions/responsive_size.dart';
import 'package:live_score/src/core/widgets/match_time_with_progress.dart';

import '../../../../core/constants/app_decorations.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/domain/entities/soccer_fixture.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../../core/l10n/app_l10n.dart';
import '../../../../core/widgets/custom_image.dart';
import 'view_team.dart';

class FixtureDetails extends StatelessWidget {
  final SoccerFixture soccerFixture;

  const FixtureDetails({super.key, required this.soccerFixture});

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.paddingOf(context).top;
    return Container(
      padding: EdgeInsets.only(
        top: topPadding + 8,
        bottom: AppSpacing.s,
        left: AppSpacing.m,
        right: AppSpacing.m,
      ),
      decoration: BoxDecoration(gradient: soccerFixture.gradientColor(context)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _LeagueRow(soccerFixture: soccerFixture),
          const SizedBox(height: AppSpacing.m),
          Row(
            children: [
              Expanded(
                child: ViewTeam(
                  team: soccerFixture.teams.home,
                  fixtureId: soccerFixture.id,
                ),
              ),
              Expanded(
                child:
                    (soccerFixture.gameTime != null &&
                            soccerFixture.gameTime! > 0)
                        ? _FixtureResult(soccerFixture: soccerFixture)
                        : _FixtureTime(soccerFixture: soccerFixture),
              ),
              Expanded(
                child: ViewTeam(
                  team: soccerFixture.teams.away,
                  fixtureId: soccerFixture.id,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.m),
          _StatusBadge(soccerFixture: soccerFixture),
          if (soccerFixture.status.isLive) ...[
            const SizedBox(height: AppSpacing.m),
            MatchTimeWithProgress(
              time: soccerFixture.gameTimeDisplay,
              mainColor: context.colorsExt.white,
              progress: (soccerFixture.gameTime ?? 0) / 90.0,
              isLive: soccerFixture.status.isLive,
            ),
            const SizedBox(height: AppSpacing.m),
          ],
        ],
      ),
    );
  }
}

class _LeagueRow extends StatelessWidget {
  const _LeagueRow({required this.soccerFixture});
  final SoccerFixture soccerFixture;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s,
        vertical: 2,
      ),
      decoration: AppDecorations.glassMorphism(
        context,
      ).copyWith(borderRadius: BorderRadius.circular(20.r)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImage(
            width: 18,
            height: 18,
            imageUrl: soccerFixture.fixtureLeague.logo,
          ),
          const SizedBox(width: AppSpacing.xs),
          Flexible(
            child: Text(
              soccerFixture.fixtureLeague.name,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: context.colorsExt.white,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _FixtureResult extends StatelessWidget {
  const _FixtureResult({required this.soccerFixture});
  final SoccerFixture soccerFixture;

  @override
  Widget build(BuildContext context) {
    final displayLarge = Theme.of(context).textTheme.displayMedium?.copyWith(
      color: context.colorsExt.white,
      fontWeight: FontWeight.bold,
      fontSize: 28,
      shadows: [
        Shadow(
          color: Colors.black.withValues(alpha: 0.3),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    );

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              soccerFixture.teams.home.score.toString(),
              style: displayLarge,
            ),
            const SizedBox(width: AppSpacing.s),
            Text(':', style: displayLarge),
            const SizedBox(width: AppSpacing.s),
            Text(
              soccerFixture.teams.away.score.toString(),
              style: displayLarge,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.s),
        _FixtureRound(soccerFixture: soccerFixture),
      ],
    );
  }
}

class _FixtureTime extends StatelessWidget {
  const _FixtureTime({required this.soccerFixture});
  final SoccerFixture soccerFixture;

  @override
  Widget build(BuildContext context) {
    final localTime =
        DateTime.parse(soccerFixture.startTime.toString()).toLocal();
    final formattedTime = DateFormat(
      'h:mm a',
      context.localeName,
    ).format(localTime);

    return Column(
      children: [
        Text(
          formattedTime,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(color: context.colorsExt.white),
        ),
        const SizedBox(height: AppSpacing.xs),
        _FixtureRound(soccerFixture: soccerFixture),
      ],
    );
  }
}

class _FixtureRound extends StatelessWidget {
  const _FixtureRound({required this.soccerFixture});
  final SoccerFixture soccerFixture;

  @override
  Widget build(BuildContext context) {
    return Text(
      soccerFixture.roundNum != null
          ? context.l10n.roundNumber(soccerFixture.roundNum.toString())
          : context.l10n.seasonNumber(soccerFixture.seasonNum.toString()),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: context.colorsExt.white.withOpacitySafe(0.9),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.soccerFixture});
  final SoccerFixture soccerFixture;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s,
        vertical: 2,
      ),
      decoration: AppDecorations.glassMorphism(context).copyWith(
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: context.colorsExt.white.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Text(
        soccerFixture.statusText,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: context.colorsExt.white,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.0,
          fontSize: 10,
        ),
      ),
    );
  }
}
