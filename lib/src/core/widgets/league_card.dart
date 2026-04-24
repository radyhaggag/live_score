import 'package:flutter/material.dart';
import 'package:live_score/src/core/constants/app_spacing.dart';
import 'package:live_score/src/core/constants/app_decorations.dart';
import 'package:live_score/src/core/extensions/context_ext.dart';
import 'package:live_score/src/core/extensions/responsive_size.dart';

import '../domain/entities/league.dart';
import 'custom_image.dart';

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

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOutCubic,
      constraints: BoxConstraints(minWidth: 84.0.w, maxWidth: 220.0.w),
      height: 45.0.h,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s),
      decoration: BoxDecoration(
        borderRadius: AppBorderRadius.chipAll,
        gradient: isSelected ? context.colorsExt.accentGradient : null,
        color: isSelected ? null : context.colorsExt.surfaceGlass,
        border: Border.all(
          color: isSelected ? context.colorsExt.white : context.colors.onSurface.withValues(alpha: 0.1),
          width: isSelected ? 2 : 1,
        ),
        boxShadow: isSelected ? [AppShadows.glowShadow(context.colors.primary)] : null,
      ),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomImage(width: 18.w, height: 18.h, imageUrl: league.logo),
            const SizedBox(width: AppSpacing.xs),
            Flexible(
              child: Text(
                leagueTitle,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: isSelected ? context.colorsExt.white : context.colors.onSurface,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
