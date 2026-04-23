import 'package:flutter/material.dart';

import '../../../../core/extensions/context_ext.dart';
import '../../../../core/theme/app_fonts.dart';
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
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        color: switch (status) {
          SoccerFixtureStatus.live => context.colorsExt.red,
          SoccerFixtureStatus.ended => context.colorsExt.blue,
          SoccerFixtureStatus.scheduled => context.colorsExt.blue,
        },
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        statusText,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: context.colorsExt.white,
          fontSize: FontSize.paragraph,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
