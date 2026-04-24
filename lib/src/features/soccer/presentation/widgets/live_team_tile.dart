import 'package:flutter/material.dart';

import 'package:live_score/src/core/constants/app_spacing.dart';

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
