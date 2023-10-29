import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_size.dart';
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
          vertical: AppPadding.p10, horizontal: AppPadding.p15),
      child: Row(
        children: [
          SizedBox(
            width: AppSize.s200,
            child: Row(
              children: [
                SizedBox(
                  width: AppSize.s30,
                  child: Text(
                    teamRank.rank.toString(),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                Image(
                  width: AppSize.s20,
                  height: AppSize.s20,
                  image: NetworkImage(teamRank.team.logo),
                ),
                const SizedBox(width: AppSize.s10),
                Flexible(
                  child: Text(
                    teamRank.team.name,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
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
                  width: AppSize.s40,
                  child: Text(
                    headersNumbers[index],
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: AppSize.s10),
          StandingsForm(form: teamRank.lastMatches),
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
    "Pts"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.grey.withOpacity(.05),
      padding: const EdgeInsets.symmetric(
          vertical: AppPadding.p10, horizontal: AppPadding.p15),
      child: Row(
        children: [
          const SizedBox(
            width: AppSize.s200,
            child: Text("Team name", style: TextStyle(fontSize: 16)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ...List.generate(
                _headers.length,
                (index) => SizedBox(
                  width: AppSize.s40,
                  child: Text(
                    _headers[index],
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(width: AppSize.s10),
          const SizedBox(
            width: AppSize.s110,
            child: Text("Form", textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }
}
