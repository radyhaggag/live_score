import 'package:flutter/material.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_size.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_values.dart';
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
                height: AppSize.s625,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(AppAssets.playground),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppPadding.p15,
                    horizontal: AppPadding.p15,
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

  Widget buildTeamHeader(
      {required BuildContext context, required Lineup lineup}) {
    return Container(
      color: AppColors.darkGreen,
      padding: const EdgeInsetsDirectional.all(AppPadding.p5),
      child: Row(
        children: [
          Image(
            fit: BoxFit.cover,
            width: AppSize.s35,
            height: AppSize.s35,
            image: NetworkImage(lineup.team.logo),
          ),
          const SizedBox(width: AppSize.s10),
          Text(
            lineup.team.name,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const Spacer(),
          Text(
            lineup.formation,
            style: const TextStyle(
                color: Colors.white, fontSize: FontSize.subTitle),
          ),
          const SizedBox(width: AppSize.s10),
        ],
      ),
    );
  }
}
