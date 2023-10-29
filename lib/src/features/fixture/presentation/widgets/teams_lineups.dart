import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_size.dart';
import '../../domain/entities/lineups.dart';
import '../../domain/entities/player.dart';

class TeamsLineups extends StatelessWidget {
  final List<Lineup> lineups;

  const TeamsLineups({super.key, required this.lineups});

  @override
  Widget build(BuildContext context) {
    List<String> teamOnePlan = lineups[0].formation.split("-");
    Iterable<String> teamTwoPlan = lineups[1].formation.split("-").reversed;
    List<Player> teamOnePlayers = lineups[0].startXI;
    Iterable<Player> teamTwoPlayers = lineups[1].startXI.reversed;

    int lineOneNumber = 0;
    int lineTwoNumber = -1;

    return Column(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  CircleAvatar(
                    radius: AppSize.s15,
                    backgroundColor: AppColors.white,
                    child: CircleAvatar(
                      radius: AppSize.s13,
                      backgroundColor:
                          HexColor("#${lineups[0].team.colors.player.primary}"),
                      child: Text(
                        teamOnePlayers[0].number.toString(),
                        style: TextStyle(
                            color: HexColor(
                                "#${lineups[0].team.colors.player.number}")),
                      ),
                    ),
                  ),
                  Text(
                    teamOnePlayers[0].name,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: AppColors.white),
                  ),
                ],
              ),
              ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: AppSize.s10),
                itemBuilder: (context, index) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ...List.generate(
                      int.parse(teamOnePlan[index]),
                      (_) {
                        lineOneNumber++;
                        List<String> playerName =
                            teamOnePlayers[lineOneNumber].name.split(" ");
                        return Expanded(
                          child: Column(
                            children: [
                              CircleAvatar(
                                backgroundColor: AppColors.white,
                                radius: AppSize.s15,
                                child: CircleAvatar(
                                  radius: AppSize.s13,
                                  backgroundColor: HexColor(
                                      "#${lineups[0].team.colors.player.primary}"),
                                  child: Text(
                                    teamOnePlayers[lineOneNumber]
                                        .number
                                        .toString(),
                                    style: TextStyle(
                                      color: HexColor(
                                          "#${lineups[0].team.colors.player.number}"),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: AppSize.s2),
                              Text(
                                playerName.length >= 3
                                    ? playerName[1] + playerName[2]
                                    : playerName.length == 2
                                        ? playerName[1]
                                        : playerName[0],
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
                itemCount: teamOnePlan.length,
              ),
            ],
          ),
        ),
        // const SizedBox(height: 80),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: AppSize.s10),
                itemBuilder: (context, index) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ...List.generate(
                      int.parse(teamTwoPlan.elementAt(index)),
                      (_) {
                        lineTwoNumber++;
                        List<String> playerName = teamTwoPlayers
                            .elementAt(lineTwoNumber)
                            .name
                            .split(" ");
                        return Expanded(
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: AppSize.s15,
                                backgroundColor: AppColors.white,
                                child: CircleAvatar(
                                  radius: AppSize.s13,
                                  backgroundColor: HexColor(
                                    "#${lineups[1].team.colors.player.primary}",
                                  ),
                                  child: Text(
                                    teamTwoPlayers
                                        .elementAt(lineTwoNumber)
                                        .number
                                        .toString(),
                                    style: TextStyle(
                                        color: HexColor(
                                            "#${lineups[1].team.colors.player.number}")),
                                  ),
                                ),
                              ),
                              const SizedBox(height: AppSize.s2),
                              Text(
                                playerName.length >= 3
                                    ? playerName[1] + playerName[2]
                                    : playerName.length == 2
                                        ? playerName[1]
                                        : playerName[0],
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
                itemCount: teamTwoPlan.length,
              ),
              Column(
                children: [
                  CircleAvatar(
                    radius: AppSize.s15,
                    backgroundColor: AppColors.white,
                    child: CircleAvatar(
                      radius: AppSize.s13,
                      backgroundColor:
                          HexColor("#${lineups[1].team.colors.player.primary}"),
                      child: Text(
                        teamTwoPlayers.elementAt(10).number.toString(),
                        style: TextStyle(
                            color: HexColor(
                                "#${lineups[1].team.colors.player.number}")),
                      ),
                    ),
                  ),
                  Text(
                    teamTwoPlayers.elementAt(10).name,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: AppColors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
