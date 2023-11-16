import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../domain/entities/league.dart';
import '../utils/app_colors.dart';
import '../utils/app_size.dart';
import '../utils/app_values.dart';

class LeagueTile extends StatelessWidget {
  final League league;

  const LeagueTile({super.key, required this.league});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppPadding.p10,
        horizontal: AppPadding.p20,
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
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
