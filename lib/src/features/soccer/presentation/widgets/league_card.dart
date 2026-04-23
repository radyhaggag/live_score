import 'package:flutter/material.dart';

import 'package:live_score/src/core/extensions/color.dart';
import 'package:live_score/src/core/extensions/context_ext.dart';

import '../../../../core/domain/entities/league.dart';
import '../../../../core/widgets/custom_image.dart';
import 'package:live_score/src/core/constants/app_spacing.dart';

class LeagueCard extends StatelessWidget {
  const LeagueCard({
    super.key,
    required this.league,
    this.isSelected = false,
    this.viewCountryName = false,
  });

  final League league;
  final bool isSelected;
  final bool viewCountryName;

  @override
  Widget build(BuildContext context) {
    final leagueTitle =
        league.name +
        (viewCountryName && league.country != null
            ? ' (${league.country?.name})'
            : '');

    return Transform.scale(
      scale: isSelected ? 1.01 : 1.0,
      child: Container(
        constraints: const BoxConstraints(minWidth: 84, maxWidth: 220),
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: isSelected ? context.colorsExt.redGradient : null,
          color:
              isSelected
                  ? null
                  : league.color != null
                  ? league.color!.toColor
                  : context.colorsExt.blueGrey,
          border:
              isSelected
                  ? Border.all(color: context.colorsExt.white, width: 2)
                  : null,
          boxShadow:
              isSelected
                  ? [
                    BoxShadow(
                      color: Colors.black.withOpacitySafe(0.25),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ]
                  : null,
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomImage(width: 18, height: 18, imageUrl: league.logo),
              const SizedBox(width: AppSpacing.xs),
              Text(
                leagueTitle,
                softWrap: false,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: context.colorsExt.white,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
