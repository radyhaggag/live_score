import 'package:flutter/material.dart';
import '../../../../core/utils/app_strings.dart';
import 'items_not_available.dart';
import 'teams_lineups.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_values.dart';
import '../../domain/entities/lineups.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_size.dart';

class LineupsView extends StatelessWidget {
  final List<Lineup> lineups;

  const LineupsView({Key? key, required this.lineups}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return lineups.isNotEmpty
        ? Column(
            children: [
              Container(
                color: AppColors.green,
                padding: const EdgeInsetsDirectional.all(AppPadding.p5),
                child: Row(
                  children: [
                    Image(
                      fit: BoxFit.cover,
                      width: AppSize.s35,
                      height: AppSize.s35,
                      image: NetworkImage(lineups[0].team.logo),
                    ),
                    const SizedBox(width: AppSize.s10),
                    Text(
                      lineups[0].team.name,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const Spacer(),
                    Text(
                      lineups[0].formation,
                      style: const TextStyle(
                          color: Colors.white, fontSize: FontSize.subTitle),
                    ),
                    const SizedBox(width: AppSize.s10),
                  ],
                ),
              ),
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
              Container(
                color: AppColors.green,
                padding: const EdgeInsetsDirectional.all(AppPadding.p5),
                child: Row(
                  children: [
                    Image(
                      fit: BoxFit.cover,
                      width: AppSize.s35,
                      height: AppSize.s35,
                      image: NetworkImage(
                        lineups[1].team.logo,
                      ),
                    ),
                    const SizedBox(width: AppSize.s10),
                    Text(
                      lineups[1].team.name,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const Spacer(),
                    Text(
                      lineups[1].formation,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: AppColors.white),
                    ),
                    const SizedBox(width: AppSize.s10),
                  ],
                ),
              ),
            ],
          )
        : const ItemsNotAvailable(
            icon: Icons.people,
            message: AppStrings.noLineups,
          );
  }
}
