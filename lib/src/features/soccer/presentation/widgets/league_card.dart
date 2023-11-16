import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/domain/entities/league.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_size.dart';
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
        borderRadius: BorderRadius.circular(AppSize.s10),
        gradient: AppColors.redGradient,
      ),
      child: Row(
        children: [
          CachedNetworkImage(
            width: AppSize.s40,
            height: AppSize.s40,
            imageUrl: league.logo,
          ),
          const SizedBox(width: AppSize.s5),
          Text(
            league.name,
            style: const TextStyle(color: AppColors.white),
          ),
        ],
      ),
    );
  }
}
