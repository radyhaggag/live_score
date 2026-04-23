import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_image.dart';
import 'package:live_score/src/core/constants/app_spacing.dart';

/// Displays a team logo and name stacked vertically for fixture cards.
class FixtureTeamInfo extends StatelessWidget {
  final String logo;
  final String name;

  const FixtureTeamInfo({super.key, required this.logo, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomImage(height: 25, width: 25, imageUrl: logo),
        const SizedBox(height: AppSpacing.s),
        Text(
          name.split(' ').length > 2
              ? name.split(' ').sublist(0, 2).join(' ')
              : name,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
