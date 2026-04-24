import 'package:flutter/material.dart';
import 'package:live_score/src/core/extensions/strings.dart';
import 'package:live_score/src/core/constants/app_spacing.dart';

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
          child: CustomImage(width: 50, height: 50, imageUrl: team.logo),
        ),
        const SizedBox(height: AppSpacing.m),
        FittedBox(
          child: Text(
            team.name.teamName,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: context.colorsExt.white),
          ),
        ),
      ],
    );
  }
}
