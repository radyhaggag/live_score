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
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.l,
        vertical: AppSpacing.xs + 1,
      ),
      decoration: BoxDecoration(
        color: switch (status) {
          SoccerFixtureStatus.live => context.colorsExt.red,
          SoccerFixtureStatus.ended => context.colorsExt.blue,
          SoccerFixtureStatus.scheduled => context.colorsExt.blue,
        },
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        statusText,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        // Use theme's bodySmall without overriding fontSize — let the theme be the source of truth.
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: context.colorsExt.white),
        textAlign: TextAlign.center,
      ),
    );
  }
}
