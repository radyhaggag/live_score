import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:live_score/src/core/extensions/responsive_size.dart';
import 'package:live_score/src/core/extensions/context_ext.dart';

import '../l10n/app_l10n.dart';
import 'package:live_score/src/core/constants/app_spacing.dart';
import '../constants/app_decorations.dart';

/// Represents the match time with progress entity/model.
class MatchTimeWithProgress extends StatefulWidget {
  final String time;
  final Color? mainColor;
  final int widthFactor;
  final bool compact;

  const MatchTimeWithProgress({
    super.key,
    required this.time,
    this.mainColor,
    this.widthFactor = 2,
    this.compact = false,
  });

  @override
  State<MatchTimeWithProgress> createState() => _MatchTimeWithProgressState();
}

class _MatchTimeWithProgressState extends State<MatchTimeWithProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.widthFactor - 1),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mainColor = widget.mainColor ?? context.colorsExt.red;
    final barWidth = widget.compact ? 20.r : 28.r;
    final barHeight = widget.compact ? 3.0 : 4.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.time.isNotEmpty ? widget.time : context.l10n.liveFallback,
          style: theme.textTheme.labelSmall?.copyWith(
            color: mainColor,
            fontWeight: FontWeight.bold,
            fontSize: widget.compact ? null : 12.sp,
          ),
          textAlign: TextAlign.center,
        ).animate(onPlay: (controller) => controller.repeat(reverse: true))
         .fade(begin: 1.0, end: 0.6, duration: 1.seconds),
        
        SizedBox(height: widget.compact ? 2 : AppSpacing.xs),
        
        Container(
          width: barWidth,
          height: barHeight,
          decoration: BoxDecoration(
            color: mainColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(barHeight / 2),
          ),
          alignment: Alignment.centerLeft,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final progressWidth = barWidth * (_controller.value / widget.widthFactor);
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: progressWidth,
                    height: barHeight,
                    decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.circular(barHeight / 2),
                      boxShadow: [AppShadows.glowShadow(mainColor)],
                    ),
                  ),
                  Positioned(
                    left: progressWidth - (barHeight * 1.5),
                    top: -(barHeight / 2),
                    child: Container(
                      width: barHeight * 2,
                      height: barHeight * 2,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: mainColor,
                            blurRadius: 4,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                    ).animate(onPlay: (c) => c.repeat(reverse: true))
                     .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.2, 1.2), duration: 800.ms),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
