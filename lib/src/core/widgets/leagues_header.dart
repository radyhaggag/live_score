import 'package:flutter/material.dart';
import 'package:live_score/src/core/constants/app_spacing.dart';
import 'package:live_score/src/core/extensions/responsive_size.dart';

import '../domain/entities/league.dart';
import '../extensions/color.dart';
import '../extensions/context_ext.dart';
import 'custom_image.dart';
import 'league_card.dart';

/// Circle-avatar league header used on the main soccer screen.
final double _kCircleHeaderHeight = 68.0.h;
final double _kLeagueAvatarRadius = 25.0.r;
final double _kLeagueLogoSize = 25.0.w;

class CircleLeaguesHeader extends StatelessWidget {
  final List<League> leagues;
  final void Function(BuildContext, League) onLeagueTap;

  const CircleLeaguesHeader({
    super.key,
    required this.leagues,
    required this.onLeagueTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: _kCircleHeaderHeight,
      padding: const EdgeInsetsDirectional.only(start: AppSpacing.l),
      decoration: BoxDecoration(
        gradient: context.colorsExt.blueGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40.r),
          topLeft: Radius.circular(40.r),
        ),
      ),
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder:
            (context, index) =>
                _buildLeagueAvatar(league: leagues[index], context: context),
        separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.s),
        itemCount: leagues.length,
      ),
    );
  }

  Widget _buildLeagueAvatar({
    required League league,
    required BuildContext context,
  }) => MouseRegion(
    cursor: SystemMouseCursors.click,
    child: InkWell(
      onTap: () => onLeagueTap(context, league),
      borderRadius: BorderRadius.circular(_kLeagueAvatarRadius),
      child: Container(
        width: _kLeagueAvatarRadius * 2,
        height: _kLeagueAvatarRadius * 2,
        decoration: BoxDecoration(
          color: league.color != null ? league.color!.toColor : context.colorsExt.white,
          shape: BoxShape.circle,
          border: Border.all(color: context.colorsExt.white.withValues(alpha: 0.8), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: CustomImage(
          fit: BoxFit.contain,
          width: _kLeagueLogoSize,
          height: _kLeagueLogoSize,
          imageUrl: league.logo,
        ),
      ),
    ),
  );
}

/// Rect-chip league header used on fixtures and standings screens.

class RectLeaguesHeader extends StatefulWidget {
  final List<League> leagues;
  final ValueChanged<League> onLeagueTap;
  final int? initialSelectedLeagueId;
  final Widget? prefixIcon;
  final VoidCallback? onPrefixIconTap;

  const RectLeaguesHeader({
    super.key,
    required this.leagues,
    required this.onLeagueTap,
    this.initialSelectedLeagueId,
    this.prefixIcon,
    this.onPrefixIconTap,
  });

  @override
  State<RectLeaguesHeader> createState() => _RectLeaguesHeaderState();
}

class _RectLeaguesHeaderState extends State<RectLeaguesHeader> {
  int? selectedLeagueId;

  @override
  void initState() {
    super.initState();
    selectedLeagueId = widget.initialSelectedLeagueId;
  }

  @override
  void didUpdateWidget(covariant RectLeaguesHeader oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialSelectedLeagueId != oldWidget.initialSelectedLeagueId) {
      selectedLeagueId = widget.initialSelectedLeagueId;
    }
  }

  void _onLeagueTap(League league) {
    widget.onLeagueTap(league);
    setState(() => selectedLeagueId = league.id);
  }

  void _onPrefixTap() {
    widget.onPrefixIconTap?.call();
    setState(() => selectedLeagueId = null);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.xs,
        horizontal: AppSpacing.xs,
      ),
      child: SizedBox(
        height: 45.0.h,
        child: Row(
          spacing: AppSpacing.s,
          children: [
            if (widget.prefixIcon != null)
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: _onPrefixTap,
                  child: widget.prefixIcon,
                ),
              ),
            Expanded(
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: widget.leagues.length,
                separatorBuilder:
                    (_, _) => const SizedBox(width: AppSpacing.xs),
                itemBuilder: (context, index) {
                  final league = widget.leagues[index];
                  final viewCountryName = widget.leagues.any(
                    (l) => l.name == league.name && l.id != league.id,
                  );
                  return MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: InkWell(
                      onTap: () => _onLeagueTap(league),
                      child: LeagueCard(
                        league: league,
                        isSelected: selectedLeagueId == league.id,
                        viewCountryName: viewCountryName,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
