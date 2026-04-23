import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:live_score/src/core/extensions/color.dart';
import 'package:live_score/src/core/extensions/fixture.dart';
import 'package:live_score/src/core/widgets/match_time_with_progress.dart';

import '../../../../core/domain/entities/soccer_fixture.dart';
import '../../../../core/l10n/app_l10n.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../../core/widgets/custom_image.dart';
import 'view_team.dart';
import 'package:live_score/src/core/constants/app_spacing.dart';

class FixtureDetails extends StatelessWidget {
  final SoccerFixture soccerFixture;

  const FixtureDetails({super.key, required this.soccerFixture});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      decoration: BoxDecoration(gradient: soccerFixture.gradientColor(context)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _LeagueRow(soccerFixture: soccerFixture),
          const SizedBox(height: AppSpacing.s),
          Row(
            children: [
              Expanded(child: ViewTeam(team: soccerFixture.teams.home)),
              Expanded(
                child:
                    (soccerFixture.gameTime != null &&
                            soccerFixture.gameTime! > 0)
                        ? _FixtureResult(soccerFixture: soccerFixture)
                        : _FixtureTime(soccerFixture: soccerFixture),
              ),
              Expanded(child: ViewTeam(team: soccerFixture.teams.away)),
            ],
          ),
          const SizedBox(height: AppSpacing.s),
          _StatusBadge(soccerFixture: soccerFixture),
          if (soccerFixture.status.isLive) ...[
            const SizedBox(height: AppSpacing.s),
            MatchTimeWithProgress(
              time: soccerFixture.gameTimeDisplay,
              mainColor: context.colorsExt.white,
              widthFactor: 4,
            ),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomImage(
          width: 20,
          height: 20,
          imageUrl: soccerFixture.fixtureLeague.logo,
        ),
        const SizedBox(width: AppSpacing.xs),
        Flexible(
          child: FittedBox(
            child: Text(
              soccerFixture.fixtureLeague.name,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: context.colorsExt.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}

class _FixtureResult extends StatelessWidget {
  const _FixtureResult({required this.soccerFixture});
  final SoccerFixture soccerFixture;

  @override
  Widget build(BuildContext context) {
    final displaySmall = Theme.of(
      context,
    ).textTheme.displaySmall?.copyWith(color: context.colorsExt.white);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              soccerFixture.teams.home.score.toString(),
              style: displaySmall,
            ),
            const SizedBox(width: AppSpacing.s),
            Text(':', style: displaySmall),
            const SizedBox(width: AppSpacing.s),
            Text(
              soccerFixture.teams.away.score.toString(),
              style: displaySmall,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
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
          ).textTheme.headlineSmall?.copyWith(color: context.colorsExt.white),
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color:
            soccerFixture.isThereWinner
                ? context.colorsExt.lightRed
                : context.colorsExt.darkBlue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        soccerFixture.statusText,
        style: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(color: context.colorsExt.white),
      ),
    );
  }
}
