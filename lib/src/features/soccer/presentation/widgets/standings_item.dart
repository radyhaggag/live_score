import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:live_score/src/core/extensions/color.dart';
import 'package:live_score/src/core/extensions/nums.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_values.dart';
import '../../domain/entities/team_rank.dart';
import 'standings_form.dart';

class StandingsItem extends StatelessWidget {
  final TeamRank teamRank;

  const StandingsItem({super.key, required this.teamRank});

  @override
  Widget build(BuildContext context) {
    List<String> headersNumbers = [
      "${teamRank.stats.played}",
      "${teamRank.stats.win}",
      "${teamRank.stats.draw}",
      "${teamRank.stats.lose}",
      "${teamRank.stats.scored}",
      "${teamRank.stats.received}",
      "${teamRank.goalsDiff}",
      "${teamRank.points}",
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppPadding.p10,
        horizontal: AppPadding.p15,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 200.width,
            child: Row(
              children: [
                SizedBox(
                  width: 30.width,
                  child: Text(
                    teamRank.rank.toString(),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                CachedNetworkImage(
                  width: 20.radius,
                  height: 20.radius,
                  imageUrl: teamRank.team.logo,
                ),
                SizedBox(width: 10.width),
                Flexible(
                  child: Text(
                    teamRank.team.name,
                    style: const TextStyle(fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    // softWrap: true,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              ...List.generate(
                headersNumbers.length,
                (index) => SizedBox(
                  width: 40.width,
                  child: Text(
                    headersNumbers[index],
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 10.width),
          StandingsForm(form: teamRank.form),
        ],
      ),
    );
  }
}

class StandingsHeaders extends StatelessWidget {
  const StandingsHeaders({super.key});
  static const List<String> _headers = [
    "PL",
    "W",
    "D",
    "L",
    "GF",
    "GA",
    "GD",
    "Pts",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.grey.withOpacitySafe(.05),
      padding: const EdgeInsets.symmetric(
        vertical: AppPadding.p10,
        horizontal: AppPadding.p15,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 200.width,
            child: Text("Team name", style: TextStyle(fontSize: 16)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ...List.generate(
                _headers.length,
                (index) => SizedBox(
                  width: 40.width,
                  child: Text(
                    _headers[index],
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 10.width),
          SizedBox(
            width: 110.width,
            child: Text("Form", textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }
}
