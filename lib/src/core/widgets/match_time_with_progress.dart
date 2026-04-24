import 'package:live_score/src/core/extensions/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:live_score/src/core/extensions/context_ext.dart';

import '../l10n/app_l10n.dart';
import 'package:live_score/src/core/constants/app_spacing.dart';

/// Represents the match time with progress entity/model.
class MatchTimeWithProgress extends StatefulWidget {
  final String time;
  final Color? mainColor;
  final int widthFactor;

  const MatchTimeWithProgress({
    super.key,
    required this.time,
    this.mainColor,
    this.widthFactor = 2,
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
    )..repeat(reverse: true); // fill → empty → fill
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

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.time.isNotEmpty ? widget.time : context.l10n.liveFallback,
          style: theme.textTheme.labelSmall?.copyWith(
            color: mainColor,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.xs),
        Container(
          width: 28.r,
          height: 3,
          decoration: BoxDecoration(
            color: mainColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(2.r),
          ),
          alignment: Alignment.centerLeft,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Container(
                width: 28.r * (_controller.value / widget.widthFactor),
                height: 3,
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
