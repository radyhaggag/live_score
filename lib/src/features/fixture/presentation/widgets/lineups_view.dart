import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:live_score/src/core/extensions/nums.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/utils/app_strings.dart';
import '../../domain/entities/lineups.dart';
import 'items_not_available.dart';
import 'teams_lineups.dart';

class LineupsView extends StatelessWidget {
  final List<Lineup> lineups;

  const LineupsView({super.key, required this.lineups});

  @override
  Widget build(BuildContext context) {
    return lineups.isNotEmpty
        ? Column(
          children: [
            buildTeamHeader(context: context, lineup: lineups[0]),
            Container(
              width: double.infinity,
              height: 625.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(AppAssets.playground),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 15,
                ),
                child: TeamsLineups(lineups: lineups),
              ),
            ),
            buildTeamHeader(context: context, lineup: lineups[1]),
          ],
        )
        : const ItemsNotAvailable(
          icon: Icons.people,
          message: AppStrings.noLineups,
        );
  }

  Widget buildTeamHeader({
    required BuildContext context,
    required Lineup lineup,
  }) {
    return Container(
      color: AppColors.darkGreen,
      padding: const EdgeInsetsDirectional.all(5),
      child: Row(
        children: [
          CachedNetworkImage(
            fit: BoxFit.cover,
            width: 35.radius,
            height: 35.radius,
            imageUrl: lineup.team.logo,
          ),
          SizedBox(width: 10.width),
          Text(lineup.team.name, style: Theme.of(context).textTheme.bodySmall),
          const Spacer(),
          Text(
            lineup.formation,
            style: const TextStyle(
              color: Colors.white,
              fontSize: FontSize.subTitle,
            ),
          ),
          SizedBox(width: 10.width),
        ],
      ),
    );
  }
}
