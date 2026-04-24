import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:live_score/src/core/extensions/responsive_size.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/constants/app_decorations.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../../core/l10n/app_l10n.dart';
import '../../../../core/widgets/custom_image.dart';
import '../../domain/entities/event.dart';

/// The full card for a single match event, aligned left or right for timeline.
class EventCard extends StatelessWidget {
  const EventCard({
    super.key,
    required this.event,
    required this.color,
    required this.isHomeTeam,
    this.isLast = false,
  });

  final Event event;
  final Color color;
  final bool isHomeTeam;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final team = event.team;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Timeline indicator
          SizedBox(
            width: 40,
            child: Column(
              children: [
                Container(
                  width: 2,
                  height: 12,
                  color: context.colorsExt.dividerSubtle,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: context.colorsExt.blue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      event.gameTimeDisplay,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 2,
                    color:
                        isLast
                            ? Colors.transparent
                            : context.colorsExt.dividerSubtle,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.s),
          // Event Content
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: AppSpacing.m, top: 4),
              padding: const EdgeInsets.all(AppSpacing.s),
              decoration: BoxDecoration(
                color: context.colorsExt.surfaceElevated,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: context.colorsExt.dividerSubtle),
                boxShadow: const [AppShadows.cardShadow],
              ),
              child: Row(
                children: [
                  CustomImage(
                    width: 20,
                    height: 20,
                    imageUrl: team?.logo ?? '',
                  ),
                  const SizedBox(width: AppSpacing.s),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            _EventIcon(event: event),
                            const SizedBox(width: AppSpacing.xs),
                            Expanded(child: _EventTitle(event: event)),
                          ],
                        ),
                        const SizedBox(height: 4),
                        if (event.type.id.isGoalOrOwnGoal ||
                            event.type.id.isMissedPenalty)
                          _EventGoal(event: event),
                        if (event.type.id.isCard)
                          _EventCardIndicator(event: event),
                        if (event.type.id.isSubstitute)
                          _EventSubstitute(event: event),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EventTitle extends StatelessWidget {
  const _EventTitle({required this.event});
  final Event event;

  @override
  Widget build(BuildContext context) {
    return Text(
      event.type.subTypeName != null
          ? '${event.type.name} (${event.type.subTypeName})'
          : event.type.name,
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
        color: context.colorsExt.textSubtle,
        fontWeight: FontWeight.w600,
      ),
      textAlign: TextAlign.start,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _EventIcon extends StatelessWidget {
  const _EventIcon({required this.event});
  final Event event;

  @override
  Widget build(BuildContext context) {
    if (event.type.id.isGoalOrOwnGoal) {
      return Icon(
            PhosphorIcons.soccerBall(PhosphorIconsStyle.fill),
            size: 16,
            color: Theme.of(context).colorScheme.onSurface,
          )
          .animate(onPlay: (controller) => controller.repeat(reverse: true))
          .scaleXY(
            begin: 1,
            end: 1.1,
            duration: 800.ms,
            curve: Curves.easeInOut,
          );
    } else if (event.type.id.isMissedPenalty) {
      return const _PenaltyMissedIcon();
    } else if (event.type.id.isYellowCard) {
      return Container(
        width: 10,
        height: 14,
        decoration: BoxDecoration(
          color: context.colorsExt.yellow,
          borderRadius: BorderRadius.circular(2),
        ),
      );
    } else if (event.type.id.isRedCard) {
      return Container(
        width: 10,
        height: 14,
        decoration: BoxDecoration(
          color: context.colorsExt.red,
          borderRadius: BorderRadius.circular(2),
        ),
      );
    } else if (event.type.id.isSubstitute) {
      return Icon(
        PhosphorIcons.arrowsLeftRight(PhosphorIconsStyle.bold),
        size: 16,
        color: context.colorsExt.blue,
      );
    }
    return Icon(
      PhosphorIcons.info(PhosphorIconsStyle.regular),
      size: 16,
      color: context.colorsExt.textSubtle,
    );
  }
}

class _EventGoal extends StatelessWidget {
  const _EventGoal({required this.event});
  final Event event;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          event.player?.displayName ?? '',
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.start,
        ),
        if (event.extraPlayerDetails != null &&
            event.extraPlayerDetails!.isNotEmpty) ...[
          const SizedBox(height: 2),
          Text(
            '${context.l10n.assist}: ${event.extraPlayerDetails!.map((e) => e.displayName).join(', ')}',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: context.colorsExt.textMuted),
            textAlign: TextAlign.start,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ],
    );
  }
}

class _PenaltyMissedIcon extends StatelessWidget {
  const _PenaltyMissedIcon();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Icon(
          PhosphorIcons.soccerBall(PhosphorIconsStyle.fill),
          size: 18,
          color: context.colorsExt.textMuted,
        ),
        Icon(
          PhosphorIcons.x(PhosphorIconsStyle.bold),
          size: 14,
          color: context.colorsExt.red,
        ),
      ],
    );
  }
}

class _EventCardIndicator extends StatelessWidget {
  const _EventCardIndicator({required this.event});
  final Event event;

  @override
  Widget build(BuildContext context) {
    return Text(
      event.player?.displayName ?? '',
      style: Theme.of(
        context,
      ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
      textAlign: TextAlign.start,
    );
  }
}

class _EventSubstitute extends StatelessWidget {
  const _EventSubstitute({required this.event});
  final Event event;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              PhosphorIcons.arrowUp(PhosphorIconsStyle.bold),
              size: 12,
              color: context.colorsExt.green,
            ),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                event.extraPlayerDetails?.firstOrNull?.name ?? '',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: context.colorsExt.green,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              PhosphorIcons.arrowDown(PhosphorIconsStyle.bold),
              size: 12,
              color: context.colorsExt.red,
            ),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                event.player?.displayName ?? '',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: context.colorsExt.red,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
