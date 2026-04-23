import 'package:flutter/material.dart';

import '../../../../core/domain/entities/league.dart';
import '../../../../core/l10n/app_l10n.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../../core/widgets/custom_image.dart';
import 'package:live_score/src/core/constants/app_spacing.dart';

/// Displays league logo, name, and optional round number.
class FixtureLeagueSection extends StatelessWidget {
  final League league;
  final int? roundNum;
  final bool showLogo;

  const FixtureLeagueSection({
    super.key,
    required this.league,
    this.roundNum,
    this.showLogo = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showLogo) ...[
              CustomImage(height: 13, width: 13, imageUrl: league.logo),
              const SizedBox(width: AppSpacing.xs),
            ],
            Flexible(
              child: Text(
                league.name,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: context.colorsExt.blueGrey,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        if (roundNum != null) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(
            context.l10n.roundNumber(roundNum.toString()),
            style: Theme.of(
              context,
            ).textTheme.labelSmall?.copyWith(color: context.colorsExt.blueGrey),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}
