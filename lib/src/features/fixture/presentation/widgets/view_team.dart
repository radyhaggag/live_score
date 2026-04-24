import 'package:flutter/material.dart';
import 'package:live_score/src/core/constants/app_decorations.dart';
import 'package:live_score/src/core/extensions/responsive_size.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/domain/entities/teams.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../../core/widgets/custom_image.dart';

class ViewTeam extends StatelessWidget {
  final Team team;
  final int fixtureId;

  const ViewTeam({super.key, required this.team, required this.fixtureId});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Hero(
          tag: 'team_${team.id}_fixture_$fixtureId',
          child: Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: context.colorsExt.white,
              shape: BoxShape.circle,
              boxShadow: const [AppShadows.elevatedShadow],
            ),
            child: CustomImage(width: 35.r, height: 35.r, imageUrl: team.logo),
          ),
        ),
        const SizedBox(height: AppSpacing.s),
        FittedBox(
          child: Text(
            team.displayName,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: context.colorsExt.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
