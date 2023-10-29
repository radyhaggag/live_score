import 'package:flutter/material.dart';
import '../../../../core/media_query.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_size.dart';
import '../../../../core/utils/app_values.dart';
import '../../domain/entities/statistics.dart';

class StatisticsView extends StatelessWidget {
  final List<Statistics> statistics;

  const StatisticsView({super.key, required this.statistics});

  @override
  Widget build(BuildContext context) {
    return statistics.isNotEmpty
        ? Column(
            children: [
              buildStatsHeader(),
              ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(AppPadding.p20),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) => buildStatsRow(
                  statisticHome: statistics[0].statistics[index],
                  statisticAway: statistics[1].statistics[index],
                ),
                separatorBuilder: (context, index) => const Divider(
                  height: AppSize.s20,
                ),
                itemCount: statistics[0].statistics.length,
              ),
            ],
          )
        : showNoStats(context);
  }

  Widget showNoStats(BuildContext context) => SizedBox(
        height: context.height / 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage(AppAssets.noStats),
              width: AppSize.s200,
              height: AppSize.s200,
            ),
            const SizedBox(height: AppSize.s10),
            Text(
              AppStrings.noStats,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: AppColors.blueGrey, letterSpacing: 1.1),
            ),
          ],
        ),
      );

  Padding buildStatsHeader() {
    return Padding(
      padding: const EdgeInsets.only(
          left: AppPadding.p10, right: AppPadding.p10, top: AppPadding.p10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image(
                width: AppSize.s20,
                height: AppSize.s20,
                image: NetworkImage(statistics[0].team.logo),
              ),
              const SizedBox(width: AppSize.s5),
              Text(statistics[0].team.name, textAlign: TextAlign.center),
            ],
          ),
          Row(
            children: [
              Image(
                width: AppSize.s20,
                height: AppSize.s20,
                image: NetworkImage(statistics[1].team.logo),
              ),
              const SizedBox(width: AppSize.s5),
              Text(statistics[1].team.name, textAlign: TextAlign.center),
            ],
          ),
        ],
      ),
    );
  }
}

Widget buildStatsRow(
        {required Statistic statisticHome, required Statistic statisticAway}) =>
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Text(statisticHome.value, textAlign: TextAlign.center),
        ),
        Expanded(
          child: Text(
            statisticHome.type,
            textAlign: TextAlign.center,
            maxLines: 1,
          ),
        ),
        Expanded(
          child: Text(statisticAway.value, textAlign: TextAlign.center),
        ),
      ],
    );
