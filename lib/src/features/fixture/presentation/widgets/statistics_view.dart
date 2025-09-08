import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:live_score/src/core/extensions/nums.dart';

import '../../../../core/media_query.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
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
              padding: const EdgeInsets.all(20),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder:
                  (context, index) => buildStatsRow(
                    statisticHome: statistics[0].statistics[index],
                    statisticAway: statistics[1].statistics[index],
                  ),
              separatorBuilder: (context, index) => Divider(height: 20.height),
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
        Image(
          image: AssetImage(AppAssets.noStats),
          width: 200.radius,
          height: 200.radius,
        ),
        SizedBox(height: 10.height),
        Text(
          AppStrings.noStats,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.blueGrey,
            letterSpacing: 1.1,
          ),
        ),
      ],
    ),
  );

  Padding buildStatsHeader() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CachedNetworkImage(
                width: 20.radius,
                height: 20.radius,
                imageUrl: statistics[0].team.logo,
              ),
              SizedBox(width: 5.width),
              Text(statistics[0].team.name, textAlign: TextAlign.center),
            ],
          ),
          Row(
            children: [
              CachedNetworkImage(
                width: 20.radius,
                height: 20.radius,
                imageUrl: statistics[1].team.logo,
              ),
              SizedBox(width: 5.width),
              Text(statistics[1].team.name, textAlign: TextAlign.center),
            ],
          ),
        ],
      ),
    );
  }
}

Widget buildStatsRow({
  required Statistic statisticHome,
  required Statistic statisticAway,
}) => Row(
  mainAxisAlignment: MainAxisAlignment.spaceAround,
  children: [
    Expanded(child: Text(statisticHome.value, textAlign: TextAlign.center)),
    Expanded(
      child: Text(statisticHome.type, textAlign: TextAlign.center, maxLines: 1),
    ),
    Expanded(child: Text(statisticAway.value, textAlign: TextAlign.center)),
  ],
);
