import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:live_score/src/core/extensions/nums.dart';

import '../../../../core/domain/entities/league.dart';
import '../../../../core/utils/app_values.dart';

class LeagueCard extends StatelessWidget {
  final League league;

  const LeagueCard({super.key, required this.league});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppPadding.p10,
        horizontal: AppPadding.p10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.radius),
        // gradient: AppColors.redGradient,
        color: HexColor(league.hexColor),
      ),
      child: Row(
        children: [
          CachedNetworkImage(
            width: 40.radius,
            height: 40.radius,
            imageUrl: league.logo,
          ),
          SizedBox(width: 5.width),
          Text(
            league.name,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
