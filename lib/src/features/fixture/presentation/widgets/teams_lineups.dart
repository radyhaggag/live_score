import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:live_score/src/core/extensions/nums.dart';

import '../../../../core/utils/app_colors.dart';
import '../../domain/entities/lineups.dart';
import '../../domain/entities/player.dart';

class TeamsLineups extends StatelessWidget {
  final List<Lineup> lineups;

  const TeamsLineups({super.key, required this.lineups});

  @override
  Widget build(BuildContext context) {
    final teamOnePlan = lineups[0].formation.split("-");
    final teamTwoPlan = lineups[1].formation.split("-").reversed;
    final teamOnePlayers = lineups[0].startXI;
    final teamTwoPlayers = lineups[1].startXI.reversed;

    int lineOneIndex = 0;
    int lineTwoIndex = -1;

    return Column(
      children: [
        Expanded(
          child: _buildTeamColumn(
            context,
            plan: teamOnePlan,
            players: teamOnePlayers,
            primaryColor: HexColor("#${lineups[0].team.colors.player.primary}"),
            numberColor: HexColor("#${lineups[0].team.colors.player.number}"),
            isReversed: false,
            lineIndex: () => ++lineOneIndex,
          ),
        ),
        Expanded(
          child: _buildTeamColumn(
            context,
            plan: teamTwoPlan,
            players: teamTwoPlayers,
            primaryColor: HexColor("#${lineups[1].team.colors.player.primary}"),
            numberColor: HexColor("#${lineups[1].team.colors.player.number}"),
            isReversed: true,
            lineIndex: () => ++lineTwoIndex,
          ),
        ),
      ],
    );
  }

  /// Build column for a team (top or bottom)
  Widget _buildTeamColumn(
    BuildContext context, {
    required Iterable<String> plan,
    required Iterable<Player> players,
    required Color primaryColor,
    required Color numberColor,
    required bool isReversed,
    required int Function() lineIndex,
  }) {
    final playersList = players.toList();

    return Column(
      mainAxisAlignment:
          isReversed
              ? MainAxisAlignment.spaceAround
              : MainAxisAlignment.spaceEvenly,
      children: [
        if (!isReversed)
          _buildCaptain(context, playersList.first, primaryColor, numberColor),
        ListView.separated(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: plan.length,
          separatorBuilder: (_, _) => SizedBox(height: 10.height),
          itemBuilder: (_, index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(int.parse(plan.elementAt(index)), (_) {
                final idx = lineIndex();
                return Expanded(
                  child: _buildPlayer(
                    context,
                    playersList[idx],
                    primaryColor,
                    numberColor,
                  ),
                );
              }),
            );
          },
        ),
        if (isReversed)
          _buildCaptain(context, playersList.last, primaryColor, numberColor),
      ],
    );
  }

  /// Common player widget
  Widget _buildPlayer(
    BuildContext context,
    Player player,
    Color primaryColor,
    Color numberColor,
  ) {
    final parts = player.name.split(" ");
    final displayName =
        parts.length >= 3
            ? parts[1] + parts[2]
            : parts.length == 2
            ? parts[1]
            : parts[0];

    return Column(
      children: [
        CircleAvatar(
          radius: 15.radius,
          backgroundColor: AppColors.white,
          child: CircleAvatar(
            radius: 13.radius,
            backgroundColor: primaryColor,
            child: Text(
              player.number.toString(),
              style: TextStyle(color: numberColor),
            ),
          ),
        ),
        SizedBox(height: 2.height),
        Text(
          displayName,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  /// Special widget for captain (GK usually)
  Widget _buildCaptain(
    BuildContext context,
    Player player,
    Color primaryColor,
    Color numberColor,
  ) {
    return Column(
      children: [
        CircleAvatar(
          radius: 15.radius,
          backgroundColor: AppColors.white,
          child: CircleAvatar(
            radius: 13.radius,
            backgroundColor: primaryColor,
            child: Text(
              player.number.toString(),
              style: TextStyle(color: numberColor),
            ),
          ),
        ),
        Text(
          player.name,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: AppColors.white),
        ),
      ],
    );
  }
}
