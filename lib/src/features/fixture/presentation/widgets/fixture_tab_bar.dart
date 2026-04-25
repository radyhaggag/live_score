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
import 'package:flutter/services.dart';

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
    final tabs = [
      (Icons.bar_chart, context.l10n.statistics),
      (Icons.people, context.l10n.lineups),
      (Icons.bolt, context.l10n.events),
    ];

    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: fixtureColor.withOpacitySafe(0.15),
        borderRadius: BorderRadius.circular(26.r),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            alignment:
                selectedIndex == 0
                    ? AlignmentDirectional.centerStart
                    : selectedIndex == 1
                    ? Alignment.center
                    : AlignmentDirectional.centerEnd,
            child: FractionallySizedBox(
              widthFactor: 1 / 3,
              child: Container(
                margin: const EdgeInsets.all(AppSpacing.xs),
                decoration: BoxDecoration(
                  color: fixtureColor,
                  borderRadius: BorderRadius.circular(22.r),
                  boxShadow: [
                    BoxShadow(
                      color: fixtureColor.withValues(alpha: 0.4),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            children: List.generate(
              tabs.length,
              (i) => Expanded(
                child: GestureDetector(
                  onTap: () {
                    HapticFeedback.selectionClick();
                    onTabSelected(i);
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          tabs[i].$1,
                          size: 16,
                          color:
                              selectedIndex == i
                                  ? context.colorsExt.white
                                  : Theme.of(context).colorScheme.onSurface,
                        ),
                        const SizedBox(width: 4),
                        FittedBox(
                          child: Text(
                            tabs[i].$2,
                            style: Theme.of(
                              context,
                            ).textTheme.labelLarge?.copyWith(
                              color:
                                  selectedIndex == i
                                      ? context.colorsExt.white
                                      : Theme.of(context).colorScheme.onSurface,
                              fontWeight:
                                  selectedIndex == i
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
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
