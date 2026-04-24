import 'package:live_score/src/core/extensions/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:live_score/src/core/constants/app_spacing.dart';

import '../../../../core/extensions/context_ext.dart';
import '../../../fixture/domain/enums.dart';

/// A colored badge showing the fixture status (live, scheduled, ended).
class FixtureStatusBadge extends StatelessWidget {
  final SoccerFixtureStatus status;
  final String statusText;

  const FixtureStatusBadge({
    super.key,
    required this.status,
    required this.statusText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLive = status == SoccerFixtureStatus.live;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.m,
        vertical: AppSpacing.xs + 1,
      ),
      decoration: BoxDecoration(
        color: switch (status) {
          SoccerFixtureStatus.live => context.colorsExt.red,
          SoccerFixtureStatus.ended => theme.colorScheme.onSurface.withValues(alpha: 0.1),
          SoccerFixtureStatus.scheduled => context.colorsExt.blue,
        },
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isLive) ...[
            _LiveIndicator(size: 6.r),
            const SizedBox(width: AppSpacing.xs),
          ],
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              statusText,
              maxLines: 1,
              style: theme.textTheme.labelSmall?.copyWith(
                color: isLive || status == SoccerFixtureStatus.scheduled
                    ? context.colorsExt.white
                    : theme.colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class _LiveIndicator extends StatefulWidget {
  final double size;
  const _LiveIndicator({required this.size});

  @override
  State<_LiveIndicator> createState() => _LiveIndicatorState();
}

class _LiveIndicatorState extends State<_LiveIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
