import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:live_score/src/core/constants/app_spacing.dart';
import 'package:go_router/go_router.dart';
import 'package:live_score/src/config/app_route.dart';
import 'package:live_score/src/core/extensions/context_ext.dart';
import 'package:live_score/src/core/extensions/responsive_size.dart';
import 'package:live_score/src/core/layout/adaptive_layout.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

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
      extendBody: true,
      appBar: AppBar(
        title: _SoccerHead(currentIndex: currentIndex),
        actions: [
          IconButton(
            onPressed: () => context.push(Routes.settings),
            icon: Icon(PhosphorIcons.gear(PhosphorIconsStyle.regular)),
            tooltip: l10n.settings,
          ),
          const SizedBox(width: AppSpacing.s),
        ],
      ),
      body: Row(
        children: [
          if (useRailNavigation) ...[
            NavigationRail(
              selectedIndex: currentIndex,
              onDestinationSelected: (index) => _onTap(context, index),
              extended: context.isExpandedWindow,
              backgroundColor: Colors.transparent,
              labelType:
                  context.isExpandedWindow
                      ? NavigationRailLabelType.none
                      : NavigationRailLabelType.all,
              destinations: [
                NavigationRailDestination(
                  icon: Icon(PhosphorIcons.house(PhosphorIconsStyle.regular)),
                  selectedIcon: Icon(PhosphorIcons.house(PhosphorIconsStyle.fill)),
                  label: Text(l10n.home),
                ),
                NavigationRailDestination(
                  icon: Icon(PhosphorIcons.soccerBall(PhosphorIconsStyle.regular)),
                  selectedIcon: Icon(PhosphorIcons.soccerBall(PhosphorIconsStyle.fill)),
                  label: Text(l10n.fixtures),
                ),
                NavigationRailDestination(
                  icon: Icon(PhosphorIcons.chartBar(PhosphorIconsStyle.regular)),
                  selectedIcon: Icon(PhosphorIcons.chartBar(PhosphorIconsStyle.fill)),
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
              : _FloatingBottomNav(
                  currentIndex: currentIndex,
                  onTap: (index) => _onTap(context, index),
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

class _FloatingBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _FloatingBottomNav({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    
    return SafeArea(
      bottom: true,
      child: Padding(
        padding: const EdgeInsets.only(
          left: AppSpacing.l,
          right: AppSpacing.l,
          bottom: AppSpacing.l,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              height: 64,
              decoration: BoxDecoration(
                color: context.colors.surface.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(32),
                border: Border.all(
                  color: context.colorsExt.dividerSubtle,
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _NavItem(
                    icon: PhosphorIcons.house(PhosphorIconsStyle.regular),
                    activeIcon: PhosphorIcons.house(PhosphorIconsStyle.fill),
                    label: l10n.home,
                    isSelected: currentIndex == 0,
                    onTap: () => onTap(0),
                  ),
                  _NavItem(
                    icon: PhosphorIcons.soccerBall(PhosphorIconsStyle.regular),
                    activeIcon: PhosphorIcons.soccerBall(PhosphorIconsStyle.fill),
                    label: l10n.fixtures,
                    isSelected: currentIndex == 1,
                    onTap: () => onTap(1),
                  ),
                  _NavItem(
                    icon: PhosphorIcons.chartBar(PhosphorIconsStyle.regular),
                    activeIcon: PhosphorIcons.chartBar(PhosphorIconsStyle.fill),
                    label: l10n.standings,
                    isSelected: currentIndex == 2,
                    onTap: () => onTap(2),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? context.colors.primary.withValues(alpha: 0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? activeIcon : icon,
              color: isSelected ? context.colors.primary : context.colorsExt.textMuted,
              size: 24,
            ),
            if (isSelected) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: context.colors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
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
      spacing: AppSpacing.m,
      children: [
        Image.asset(AppAssets.appLogo, height: 32.h),
        Text(
          context.l10n.bottomNavigationTitle(currentIndex),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
