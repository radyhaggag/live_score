import 'package:flutter/material.dart';

import 'package:live_score/src/core/extensions/strings.dart';

import '../../../../core/extensions/context_ext.dart';
import '../../domain/entities/fixture_details.dart';
import 'package:live_score/src/core/constants/app_spacing.dart';

/// A single player marker on the lineup field.
class LineupPlayer extends StatelessWidget {
  const LineupPlayer({
    super.key,
    required this.player,
    required this.primaryColor,
    required this.numberColor,
    this.compact = false,
  });

  final FixturePlayerInfo player;
  final Color primaryColor;
  final Color numberColor;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final outerRadius = compact ? 12.0 : 13.0;
    final innerRadius = compact ? 10.0 : 11.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: outerRadius,
            backgroundColor: context.colorsExt.white,
            child: CircleAvatar(
              radius: innerRadius,
              backgroundColor: primaryColor,
              child: Text(
                player.player.number.toString(),
                style: Theme.of(
                  context,
                ).textTheme.labelSmall?.copyWith(color: numberColor),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            player.player.name.playerName,
            textAlign: TextAlign.center,
            maxLines: compact ? 1 : 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(
              context,
            ).textTheme.labelSmall?.copyWith(color: context.colorsExt.white),
          ),
        ],
      ),
    );
  }
}
