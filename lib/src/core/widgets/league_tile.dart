import 'package:flutter/material.dart';
import 'package:live_score/src/core/extensions/nums.dart';
import 'package:live_score/src/core/widgets/custom_image.dart';

import '../domain/entities/league.dart';
import '../utils/app_colors.dart';

class LeagueTile extends StatelessWidget {
  final League league;

  const LeagueTile({super.key, required this.league});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.radius),
        gradient: AppColors.redGradient,
      ),
      child: Row(
        children: [
          CustomImage(
            width: 40.radius,
            height: 40.radius,
            imageUrl: league.logo,
          ),
          SizedBox(width: 5.width),
          Text(league.name, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
