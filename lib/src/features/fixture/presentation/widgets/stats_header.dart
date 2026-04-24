import 'package:flutter/material.dart';
import 'package:live_score/src/core/constants/app_spacing.dart';

import '../../../../core/domain/entities/teams.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../../core/widgets/custom_image.dart';

/// Header showing both team logos and names for the statistics view.
class StatsHeader extends StatelessWidget {
  final Teams teams;

  const StatsHeader({super.key, required this.teams});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.m,
            vertical: AppSpacing.m,
          ),
          child: Row(
            children: [
              Expanded(
                child: _StatsTeamInfo(
                  logo: teams.home.logo,
                  name: teams.home.displayName,
                  alignment: MainAxisAlignment.start,
                ),
              ),
              const SizedBox(width: AppSpacing.xl),
              Expanded(
                child: _StatsTeamInfo(
                  logo: teams.away.logo,
                  name: teams.away.displayName,
                  alignment: MainAxisAlignment.end,
                  isReverse: true,
                ),
              ),
            ],
          ),
        ),
        Divider(
          height: 1,
          thickness: 1,
          color: context.colorsExt.dividerSubtle,
        ),
      ],
    );
  }
}

class _StatsTeamInfo extends StatelessWidget {
  final String logo;
  final String name;
  final MainAxisAlignment alignment;
  final bool isReverse;

  const _StatsTeamInfo({
    required this.logo,
    required this.name,
    required this.alignment,
    this.isReverse = false,
  });

  @override
  Widget build(BuildContext context) {
    final logoWidget = Container(
      padding: const EdgeInsets.all(AppSpacing.xs - 2),
      decoration: BoxDecoration(
        color: context.colorsExt.surfaceElevated,
        shape: BoxShape.circle,
        border: Border.all(color: context.colorsExt.dividerSubtle, width: 1),
      ),
      child: CustomImage(width: 24, height: 24, imageUrl: logo),
    );

    final nameWidget = Flexible(
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          name,
          maxLines: 1,
          textAlign: isReverse ? TextAlign.end : TextAlign.start,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colors.onSurface,
          ),
        ),
      ),
    );

    return Row(
      mainAxisAlignment: alignment,
      children:
          isReverse
              ? [nameWidget, const SizedBox(width: AppSpacing.s), logoWidget]
              : [logoWidget, const SizedBox(width: AppSpacing.s), nameWidget],
    );
  }
}
