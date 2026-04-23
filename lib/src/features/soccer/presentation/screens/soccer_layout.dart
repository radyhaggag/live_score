import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:live_score/src/config/app_route.dart';
import 'package:live_score/src/core/layout/adaptive_layout.dart';

import '../../../../core/l10n/app_l10n.dart';
import '../../../../core/constants/app_assets.dart';

class SoccerLayout extends StatelessWidget {
  const SoccerLayout({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    final l10n = context.l10n;
    final useRailNavigation = !context.isCompactWindow;

    final int currentIndex = switch (location) {
      Routes.soccer => 0,
      Routes.fixtures => 1,
      Routes.standings => 2,
      _ => 0,
    };

    return Scaffold(
      appBar: AppBar(
        title: _SoccerHead(currentIndex: currentIndex),
        actions: [
          IconButton(
            onPressed: () => context.push(Routes.settings),
            icon: const Icon(Icons.settings_outlined),
            tooltip: l10n.settings,
          ),
        ],
      ),
      body: Row(
        children: [
          if (useRailNavigation) ...[
            NavigationRail(
              selectedIndex: currentIndex,
              onDestinationSelected: (index) => _onTap(context, index),
              extended: context.isExpandedWindow,
              labelType:
                  context.isExpandedWindow
                      ? NavigationRailLabelType.none
                      : NavigationRailLabelType.all,
              destinations: [
                NavigationRailDestination(
                  icon: const Icon(Icons.home),
                  label: Text(l10n.home),
                ),
                NavigationRailDestination(
                  icon: const Icon(Icons.sports_soccer_rounded),
                  label: Text(l10n.fixtures),
                ),
                NavigationRailDestination(
                  icon: const Icon(Icons.bar_chart),
                  label: Text(l10n.standings),
                ),
              ],
            ),
            const VerticalDivider(width: 1),
          ],
          Expanded(child: AdaptiveContentArea(child: child)),
        ],
      ),
      bottomNavigationBar:
          useRailNavigation
              ? null
              : BottomNavigationBar(
                currentIndex: currentIndex,
                onTap: (index) => _onTap(context, index),
                items: [
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.home),
                    label: l10n.home,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.sports_soccer_rounded),
                    label: l10n.fixtures,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.bar_chart),
                    label: l10n.standings,
                  ),
                ],
              ),
    );
  }

  void _onTap(BuildContext context, int index) => switch (index) {
    0 => context.go(Routes.soccer),
    1 => context.go(Routes.fixtures),
    2 => context.go(Routes.standings),
    _ => null,
  };
}

class _SoccerHead extends StatelessWidget {
  const _SoccerHead({required this.currentIndex});

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 12,
      children: [
        Image.asset(AppAssets.appLogo, height: 32),
        Text(
          context.l10n.bottomNavigationTitle(currentIndex),
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}
