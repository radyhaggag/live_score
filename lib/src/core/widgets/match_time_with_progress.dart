import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:live_score/src/core/extensions/context_ext.dart';
import 'package:live_score/src/core/extensions/responsive_size.dart';

import '../constants/app_decorations.dart';
import '../l10n/app_l10n.dart';

/// Represents the match time with progress entity/model.
class MatchTimeWithProgress extends StatefulWidget {
  final String time;
  final Color? mainColor;
  final double progress;
  final bool compact;
  final bool isLive;

  const MatchTimeWithProgress({
    super.key,
    required this.time,
    this.mainColor,
    this.progress = 0.0,
    this.compact = false,
    this.isLive = true,
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
      duration: 1.seconds,
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
    final barWidth = widget.compact ? 24.r : 32.r;
    final barHeight = widget.compact ? 3.0 : 4.0;
    
    // Clamp progress between 0 and 1
    final clampedProgress = widget.progress.clamp(0.0, 1.0);
    final progressWidth = barWidth * clampedProgress;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.time.isNotEmpty ? widget.time : context.l10n.liveFallback,
          style: theme.textTheme.labelSmall?.copyWith(
            color: mainColor,
            fontWeight: FontWeight.bold,
            fontSize: widget.compact ? 10.sp : 12.sp,
          ),
          textAlign: TextAlign.center,
        ).animate(onPlay: (controller) => controller.repeat(reverse: true))
         .fade(begin: 1.0, end: 0.6, duration: 1.seconds),
        
        const SizedBox(height: 2),
        
        Container(
          width: barWidth,
          height: barHeight,
          decoration: BoxDecoration(
            color: mainColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(barHeight / 2),
          ),
          alignment: Alignment.centerLeft,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Static Progress Bar
              Container(
                width: progressWidth,
                height: barHeight,
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.circular(barHeight / 2),
                  boxShadow: [AppShadows.glowShadow(mainColor)],
                ),
              ),
              // Indicator Dot (with pulse if live)
              if (widget.isLive)
                Positioned(
                  left: progressWidth - (barHeight),
                  top: -(barHeight / 2),
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Container(
                        width: barHeight * 2,
                        height: barHeight * 2,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: mainColor.withValues(alpha: 0.5),
                              blurRadius: 4 * _controller.value,
                              spreadRadius: 2 * _controller.value,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
