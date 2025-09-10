import 'package:flutter/material.dart';
import 'package:live_score/src/core/extensions/nums.dart';

import '../../../../core/domain/entities/teams.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_image.dart';

class ViewTeam extends StatelessWidget {
  final Team team;

  const ViewTeam({super.key, required this.team});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 35.radius,
          child: CustomImage(
            fit: BoxFit.cover,
            width: 50.radius,
            height: 50.radius,
            imageUrl: team.logo,
          ),
        ),
        SizedBox(height: 10.height),
        FittedBox(
          child: Text(
            team.name.split(" ").length >= 3
                ? team.name.split(" ").sublist(0, 2).join(" ")
                : team.name,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: AppColors.white),
          ),
        ),
      ],
    );
  }
}
