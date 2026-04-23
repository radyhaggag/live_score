import 'package:flutter/material.dart';
import 'package:live_score/src/core/extensions/strings.dart';

import '../../../../core/l10n/app_l10n.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../../core/widgets/custom_image.dart';
import '../../domain/entities/event.dart';
import 'package:live_score/src/core/constants/app_spacing.dart';

/// The full card for a single match event.
class EventCard extends StatelessWidget {
  const EventCard({super.key, required this.event, required this.color});

  final Event event;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12,
          children: [
            _EventTeamHeader(event: event),
            _EventDetailsRow(event: event, color: color),
          ],
        ),
      ),
    );
  }
}

/// Header row showing the team that performed the event.
class _EventTeamHeader extends StatelessWidget {
  const _EventTeamHeader({required this.event});
  final Event event;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomImage(width: 20, height: 20, imageUrl: event.team?.logo ?? ''),
        const SizedBox(width: AppSpacing.s),
        Flexible(
          child: Text(
            event.team?.name.teamName ?? '',
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(color: context.colorsExt.blueGrey),
          ),
        ),
      ],
    );
  }
}

/// The main details row: time badge + event type and sub-detail.
class _EventDetailsRow extends StatelessWidget {
  const _EventDetailsRow({required this.event, required this.color});
  final Event event;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 14,
          backgroundColor: color,
          child: FittedBox(
            child: Text(
              event.gameTimeDisplay,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: context.colorsExt.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.m),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      event.type.name,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  if (event.type.subTypeName != null)
                    Text(
                      event.type.subTypeName ?? '',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                ],
              ),
              if (event.type.id.isGoalOrOwnGoal ||
                  event.type.id.isMissedPenalty)
                _EventGoal(event: event),
              if (event.type.id.isCard) _EventCardIndicator(event: event),
              if (event.type.id.isSubstitute) _EventSubstitute(event: event),
            ],
          ),
        ),
      ],
    );
  }
}

/// Shows the goal scorer and assist provider.
class _EventGoal extends StatelessWidget {
  const _EventGoal({required this.event});
  final Event event;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            event.player?.name.playerName ?? '',
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(color: context.colorsExt.blue),
          ),
        ),
        const SizedBox(width: AppSpacing.s),
        event.type.id.isGoalOrOwnGoal
            ? const Icon(Icons.sports_soccer, size: 24)
            : const _PenaltyMissedIcon(),
        const SizedBox(width: AppSpacing.s),
        Expanded(
          child: Text(
            event.extraPlayerDetails != null &&
                    event.extraPlayerDetails!.isNotEmpty
                ? '${context.l10n.assist}: ${event.extraPlayerDetails!.map((e) => e.name.playerName).join(', ')}'
                : '',
            textAlign: TextAlign.end,
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(color: context.colorsExt.green),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

/// Shows the penalty missed icon (soccer ball + X overlay).
class _PenaltyMissedIcon extends StatelessWidget {
  const _PenaltyMissedIcon();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        const Icon(Icons.sports_soccer, size: 24),
        CircleAvatar(
          radius: 8,
          backgroundColor: context.colorsExt.red,
          child: Icon(Icons.close, color: context.colorsExt.white, size: 10),
        ),
      ],
    );
  }
}

/// Shows the yellow or red card indicator.
class _EventCardIndicator extends StatelessWidget {
  const _EventCardIndicator({required this.event});
  final Event event;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            event.player?.name.playerName ?? '',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        const SizedBox(width: AppSpacing.s),
        Container(
          color:
              event.type.id.isYellowCard
                  ? context.colorsExt.yellow
                  : context.colorsExt.red,
          width: 18,
          height: 24,
        ),
      ],
    );
  }
}

/// Shows the substitution (player off → player on).
class _EventSubstitute extends StatelessWidget {
  const _EventSubstitute({required this.event});
  final Event event;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            event.player?.name.playerName ?? '',
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(color: context.colorsExt.red),
          ),
        ),
        const SizedBox(width: AppSpacing.s),
        const Image(width: 28, height: 28, image: AssetImage(AppAssets.subs)),
        const SizedBox(width: AppSpacing.s),
        Expanded(
          child: Text(
            event.extraPlayerDetails != null &&
                    event.extraPlayerDetails!.isNotEmpty
                ? event.extraPlayerDetails!.first.name
                : '',
            textAlign: TextAlign.end,
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(color: context.colorsExt.green),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
