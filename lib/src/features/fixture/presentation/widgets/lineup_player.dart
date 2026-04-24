import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:live_score/src/core/constants/app_spacing.dart';
import 'package:live_score/src/core/extensions/strings.dart';

import '../../../../core/extensions/context_ext.dart';
import '../../domain/entities/fixture_details.dart';

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
    final double markerSize = compact ? 24.0 : 29.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: markerSize,
            height: markerSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  context.colorsExt.white,
                  context.colorsExt.white.withValues(alpha: 0.7),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.4),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: primaryColor,
                ),
                alignment: Alignment.center,
                child: Text(
                  player.player.number.toString(),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: numberColor,
                        fontWeight: FontWeight.w900,
                        fontSize: compact ? 9 : 11,
                      ),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.1),
                    width: 0.5,
                  ),
                ),
                child: Text(
                  player.player.name.playerName,
                  textAlign: TextAlign.center,
                  maxLines: compact ? 1 : 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: context.colorsExt.white,
                        fontWeight: FontWeight.w600,
                        fontSize: compact ? 8 : 9,
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
