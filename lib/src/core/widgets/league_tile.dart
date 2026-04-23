import 'package:flutter/material.dart';
import 'package:live_score/src/core/widgets/custom_image.dart';
import 'package:live_score/src/core/constants/app_spacing.dart';

import '../domain/entities/league.dart';
import 'package:live_score/src/core/extensions/context_ext.dart';

/// Represents the league tile entity/model.
class LeagueTile extends StatelessWidget {
  final League league;

  const LeagueTile({super.key, required this.league});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: context.colorsExt.redGradient,
      ),
      child: Row(
        children: [
          CustomImage(width: 40, height: 40, imageUrl: league.logo),
          const SizedBox(width: AppSpacing.s),
          Text(league.name, style: TextStyle(color: context.colorsExt.white)),
        ],
      ),
    );
  }
}
