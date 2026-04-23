import 'package:flutter/material.dart';
import 'package:live_score/src/core/extensions/strings.dart';

import '../../../../core/domain/entities/teams.dart';
import '../../../../core/widgets/custom_image.dart';
import 'package:live_score/src/core/constants/app_spacing.dart';

/// Header showing both team logos and names for the statistics view.
class StatsHeader extends StatelessWidget {
  final Teams teams;

  const StatsHeader({super.key, required this.teams});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Row(
        children: [
          Expanded(
            child: _StatsTeamInfo(
              logo: teams.home.logo,
              name: teams.home.name,
              alignment: MainAxisAlignment.start,
            ),
          ),
          const SizedBox(width: AppSpacing.xl),
          Expanded(
            child: _StatsTeamInfo(
              logo: teams.away.logo,
              name: teams.away.name,
              alignment: MainAxisAlignment.end,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatsTeamInfo extends StatelessWidget {
  final String logo;
  final String name;
  final MainAxisAlignment alignment;

  const _StatsTeamInfo({
    required this.logo,
    required this.name,
    required this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignment,
      children: [
        CustomImage(width: 20, height: 20, imageUrl: logo),
        const SizedBox(width: AppSpacing.xs),
        Flexible(
          child: Text(
            name.teamName,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ],
    );
  }
}
