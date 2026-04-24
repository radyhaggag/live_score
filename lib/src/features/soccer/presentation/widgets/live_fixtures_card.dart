import 'package:flutter/material.dart';
import 'package:live_score/src/core/constants/app_spacing.dart';
import 'package:live_score/src/core/extensions/fixture.dart';
import 'package:live_score/src/core/extensions/responsive_size.dart';
import 'package:live_score/src/core/extensions/strings.dart';

import '../../../../core/domain/entities/soccer_fixture.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../../core/widgets/custom_image.dart';
import '../../../../core/widgets/match_time_with_progress.dart';
import 'live_team_logo.dart';
import 'live_team_tile.dart';

/// A compact card displaying a live fixture in the horizontal rail.
class LiveFixtureCard extends StatelessWidget {
  final SoccerFixture soccerFixture;
  final double? width;

  const LiveFixtureCard({super.key, required this.soccerFixture, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 200.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        gradient: soccerFixture.gradientColor(context),
        boxShadow: [
          BoxShadow(
            color: soccerFixture.gradientColor(context).colors.first.withValues(alpha: 0.4),
            blurRadius: 12.r,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.l,
        vertical: AppSpacing.s,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: AppSpacing.s,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: AppSpacing.s,
            children: [
              CustomImage(
                height: 22.w,
                width: 22.w,
                imageUrl: soccerFixture.fixtureLeague.logo,
              ),
              Flexible(
                child: Text(
                  soccerFixture.fixtureLeague.name,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: context.colorsExt.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              LiveTeamLogo(
                logo: soccerFixture.teams.home.logo,
                radius: 14.r,
                imageSize: 22.w,
              ),
              LiveTeamLogo(
                logo: soccerFixture.teams.away.logo,
                radius: 14.r,
                imageSize: 22.w,
              ),
            ],
          ),
          LiveTeamTile(
            name: soccerFixture.teams.home.name.teamName,
            goals: soccerFixture.teams.home.score.toString(),
            teamTextStyle: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: context.colorsExt.white),
            goalsTextStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: context.colorsExt.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          LiveTeamTile(
            name: soccerFixture.teams.away.name.teamName,
            goals: soccerFixture.teams.away.score.toString(),
            teamTextStyle: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: context.colorsExt.white),
            goalsTextStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: context.colorsExt.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          MatchTimeWithProgress(
            time: soccerFixture.gameTimeDisplay,
            mainColor: context.colorsExt.white,
            widthFactor: 3,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.l,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: context.colorsExt.white.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _LiveIndicator(size: 6.r, color: context.colorsExt.red),
                const SizedBox(width: AppSpacing.s),
                Text(
                  soccerFixture.statusText,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: context.colorsExt.red,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LiveIndicator extends StatefulWidget {
  final double size;
  final Color color;
  const _LiveIndicator({required this.size, required this.color});

  @override
  State<_LiveIndicator> createState() => _LiveIndicatorState();
}

class _LiveIndicatorState extends State<_LiveIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: widget.color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
