import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:live_score/src/core/extensions/color.dart';
import 'package:live_score/src/core/extensions/nums.dart';
import 'package:live_score/src/core/utils/app_colors.dart';

import '../../../../core/domain/entities/league.dart';
import '../../../../core/widgets/custom_image.dart';

class LeagueCard extends StatelessWidget {
  final League league;
  final bool isSelected;

  const LeagueCard({super.key, required this.league, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: isSelected ? 1.05 : 1.0, // Slightly scale up when selected
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.radius),
          gradient: isSelected ? AppColors.redGradient : null,
          color:
              isSelected
                  ? null
                  : league.color != null
                  ? HexColor(league.color!)
                  : AppColors.blueGrey,
          border:
              isSelected
                  ? Border.all(
                    color: AppColors.white,
                    width: 2,
                  ) // Add white border when selected
                  : null,
          boxShadow:
              isSelected
                  ? [
                    BoxShadow(
                      color: AppColors.black.withOpacitySafe(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ]
                  : null, // Add shadow when selected
        ),
        child: Row(
          children: [
            CustomImage(
              width: 40.radius,
              height: 40.radius,
              imageUrl: league.logo,
            ),
            SizedBox(width: 5.width),
            Text(
              league.name,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.white,
                fontWeight:
                    isSelected
                        ? FontWeight.bold
                        : FontWeight.normal, // Bold text when selected
              ),
            ),
            if (isSelected) // Add a checkmark icon when selected
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Icon(
                  Icons.check_circle,
                  color: AppColors.white,
                  size: 16,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
