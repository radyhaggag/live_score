import 'package:flutter/material.dart';
import 'package:live_score/src/core/extensions/color.dart';

import '../../../../core/extensions/context_ext.dart';
import '../../../../core/widgets/custom_image.dart';
import 'package:live_score/src/core/constants/app_spacing.dart';

/// A team's logo inside a white circular avatar for the live fixture card.
class LiveTeamLogo extends StatelessWidget {
  const LiveTeamLogo({
    super.key,
    required this.logo,
    required this.radius,
    required this.imageSize,
  });

  final String logo;
  final double radius;
  final double imageSize;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: context.colorsExt.white,
      radius: radius,
      child: CustomImage(width: imageSize, height: imageSize, imageUrl: logo),
    );
  }
}

/// A row showing a team name and their score in the live fixture card.
class LiveTeamTile extends StatelessWidget {
  const LiveTeamTile({
    super.key,
    required this.name,
    required this.goals,
    required this.teamTextStyle,
    required this.goalsTextStyle,
  });

  final String name;
  final String goals;
  final TextStyle? teamTextStyle;
  final TextStyle? goalsTextStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            name,
            maxLines: 1,
            softWrap: false,
            overflow: TextOverflow.ellipsis,
            style: teamTextStyle,
          ),
        ),
        const SizedBox(width: AppSpacing.s),
        Text(goals, style: goalsTextStyle),
      ],
    );
  }
}

/// A sheet action button row used in the league bottom sheet.
class SheetAction extends StatelessWidget {
  const SheetAction({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: context.colorsExt.white.withOpacitySafe(0.12),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: context.colorsExt.white.withOpacitySafe(0.18),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: context.colorsExt.white.withOpacitySafe(0.15),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(icon, color: context.colorsExt.white),
                ),
                const SizedBox(width: AppSpacing.m),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(
                          color: context.colorsExt.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: context.colorsExt.white.withOpacitySafe(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: context.colorsExt.white,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
