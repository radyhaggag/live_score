import 'package:flutter/material.dart';
import 'package:live_score/src/core/constants/app_decorations.dart';
import 'package:live_score/src/core/constants/app_spacing.dart';
import 'package:live_score/src/core/extensions/fixture.dart';
import 'package:live_score/src/core/extensions/responsive_size.dart';
import 'package:live_score/src/core/theme/app_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

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
        borderRadius: AppBorderRadius.cardAll,
        gradient: soccerFixture.gradientColor(context),
        boxShadow: [
          BoxShadow(
            color: soccerFixture.gradientColor(context).colors.first.withValues(alpha: 0.4),
            blurRadius: 16.r,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.l,
        vertical: AppSpacing.m,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: AppSpacing.xs,
            children: [
              CustomImage(
                height: 18.w,
                width: 18.w,
                imageUrl: soccerFixture.fixtureLeague.logo,
              ),
              Flexible(
                child: Text(
                  soccerFixture.fixtureLeague.name,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: context.colorsExt.white.withValues(alpha: 0.9),
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                LiveTeamLogo(
                  logo: soccerFixture.teams.home.logo,
                  radius: 16.r,
                  imageSize: 24.w,
                ),
                Text(
                  'VS',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: context.colorsExt.white.withValues(alpha: 0.7),
                    fontWeight: FontWeight.bold,
                    letterSpacing: AppLetterSpacing.extraWide,
                  ),
                ),
                LiveTeamLogo(
                  logo: soccerFixture.teams.away.logo,
                  radius: 16.r,
                  imageSize: 24.w,
                ),
              ],
            ),
          ),
          
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LiveTeamTile(
                name: soccerFixture.teams.home.displayName,
                goals: soccerFixture.teams.home.score.toString(),
                teamTextStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: context.colorsExt.white,
                  fontWeight: FontWeight.w500,
                ),
                goalsTextStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: context.colorsExt.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 2),
              LiveTeamTile(
                name: soccerFixture.teams.away.displayName,
                goals: soccerFixture.teams.away.score.toString(),
                teamTextStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: context.colorsExt.white,
                  fontWeight: FontWeight.w500,
                ),
                goalsTextStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: context.colorsExt.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: AppSpacing.xs),
          
          MatchTimeWithProgress(
            time: soccerFixture.gameTimeDisplay,
            mainColor: context.colorsExt.white,
            progress: (soccerFixture.gameTime ?? 0) / 90.0,
            compact: true,
            isLive: soccerFixture.status.isLive,
          ),
          
          Container(
            margin: const EdgeInsets.only(top: AppSpacing.s),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.m,
              vertical: 4,
            ),
            decoration: AppDecorations.glassMorphism(context).copyWith(
              borderRadius: BorderRadius.circular(20.r),
              color: context.colorsExt.white.withValues(alpha: 0.2),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  PhosphorIcons.clock(PhosphorIconsStyle.fill),
                  size: 12,
                  color: context.colorsExt.white,
                ),
                const SizedBox(width: 6),
                Text(
                  soccerFixture.statusText,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: context.colorsExt.white,
                    fontWeight: FontWeight.w700,
                    letterSpacing: AppLetterSpacing.wide,
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
