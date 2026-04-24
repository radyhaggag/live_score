import 'package:live_score/src/core/extensions/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:live_score/src/core/extensions/color.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../../core/l10n/app_l10n.dart';
import '../../domain/entities/fixture_details.dart';
import '../../domain/entities/statistics.dart';
import '../widgets/events_view.dart';
import '../widgets/lineups_view.dart';
import '../widgets/statistics_view.dart';

/// The tab bar with Statistics, Lineups, Events buttons.
class FixtureTabBar extends StatelessWidget {
  const FixtureTabBar({
    super.key,
    required this.selectedIndex,
    required this.fixtureColor,
    required this.onTabSelected,
  });

  final int selectedIndex;
  final Color fixtureColor;
  final void Function(int) onTabSelected;

  @override
  Widget build(BuildContext context) {
    final labels = [
      context.l10n.statistics,
      context.l10n.lineups,
      context.l10n.events,
    ];

    return DecoratedBox(
      decoration: BoxDecoration(
        color: fixtureColor.withOpacitySafe(0.12),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xs),
        child: Row(
          children: List.generate(
            labels.length,
            (i) => _TabBarButton(
              label: labels[i],
              isSelected: selectedIndex == i,
              color: fixtureColor,
              onPressed: () => onTabSelected(i),
            ),
          ),
        ),
      ),
    );
  }
}

class _TabBarButton extends StatelessWidget {
  const _TabBarButton({
    required this.label,
    required this.isSelected,
    required this.color,
    required this.onPressed,
  });

  final String label;
  final bool isSelected;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xs),
        child: FilledButton(
          onPressed: onPressed,
          style: FilledButton.styleFrom(
            backgroundColor: isSelected ? color : color.withOpacitySafe(0.72),
            foregroundColor: context.colorsExt.white,
            padding: const EdgeInsets.symmetric(
              vertical: AppSpacing.l - 2, // 14dp
              horizontal: AppSpacing.m,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.r),
            ),
          ),
          child: Text(label, textAlign: TextAlign.center),
        ),
      ),
    );
  }
}

/// Renders the content for the currently selected fixture tab.
class FixtureTabContent extends StatelessWidget {
  const FixtureTabContent({
    super.key,
    required this.selectedIndex,
    this.statistics,
    this.fixtureDetails,
    required this.fixtureColor,
  });

  final int selectedIndex;
  final Statistics? statistics;
  final FixtureDetails? fixtureDetails;
  final Color fixtureColor;

  @override
  Widget build(BuildContext context) {
    return switch (selectedIndex) {
      0 => StatisticsView(
        key: ValueKey(statistics?.hashCode ?? 'no_statistics'),
        statistics: statistics,
      ),
      1 => LineupsView(
        key: ValueKey(fixtureDetails?.hashCode ?? 'no_details'),
        fixtureDetails: fixtureDetails,
        color: fixtureColor,
      ),
      _ => EventsView(
        key: ValueKey(fixtureDetails?.hashCode ?? 'no_details'),
        fixtureDetails: fixtureDetails,
        color: fixtureColor,
      ),
    };
  }
}
