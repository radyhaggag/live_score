import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:live_score/src/core/extensions/nums.dart';
import 'package:live_score/src/core/extensions/strings.dart';

import '../../../../core/utils/app_colors.dart';
import '../../domain/entities/fixture_details.dart';

class TeamsLineups extends StatelessWidget {
  final FixtureDetails fixtureDetails;

  const TeamsLineups({super.key, required this.fixtureDetails});

  @override
  Widget build(BuildContext context) {
    final homeTeam = fixtureDetails.fixture.teams.home;
    final awayTeam = fixtureDetails.fixture.teams.away;
    final homePlan = homeTeam.lineup?.formation.split('-').toList();
    final awayPlan = awayTeam.lineup?.formation.split('-').reversed.toList();
    final homePlayers =
        fixtureDetails.homePlayersInfo
            .where((player) => player.lineupMember.isStarting)
            .toList();
    final awayPlayers =
        fixtureDetails.awayPlayersInfo
            .where((player) => player.lineupMember.isStarting)
            .toList();

    // Sort players by field position
    if (homePlayers.any((player) => player.lineupMember.yardInfo != null)) {
      homePlayers.sort((a, b) {
        return a.lineupMember.yardInfo!.fieldPosition.compareTo(
          b.lineupMember.yardInfo!.fieldPosition,
        );
      });
    }

    if (awayPlayers.any((player) => player.lineupMember.yardInfo != null)) {
      awayPlayers.sort((a, b) {
        return b.lineupMember.yardInfo!.fieldPosition.compareTo(
          a.lineupMember.yardInfo!.fieldPosition,
        );
      });
    }

    int lineOneIndex = 0;
    int lineTwoIndex = -1;

    return Column(
      children: [
        Expanded(
          child: _buildTeamColumn(
            context,
            plan: homePlan!,
            players: homePlayers,
            primaryColor: HexColor('#${homeTeam.awayColor ?? homeTeam.color}'),
            // Dynamically compute number color based on primaryColor
            numberColor: getContrastingNumberColor(
              HexColor('#${homeTeam.awayColor ?? homeTeam.color}'),
            ),
            isReversed: false,
            lineIndex: () => ++lineOneIndex,
          ),
        ),
        Expanded(
          child: _buildTeamColumn(
            context,
            plan: awayPlan!,
            players: awayPlayers,
            primaryColor: HexColor('#${awayTeam.color ?? awayTeam.awayColor}'),
            // Dynamically compute number color based on primaryColor
            numberColor: getContrastingNumberColor(
              HexColor('#${awayTeam.color ?? awayTeam.awayColor}'),
            ),
            isReversed: true,
            lineIndex: () => ++lineTwoIndex,
          ),
        ),
      ],
    );
  }

  // Helper function to calculate luminance and pick a contrasting color
  Color getContrastingNumberColor(Color backgroundColor) {
    // Calculate luminance using the relative luminance formula
    // Luminance = 0.299R + 0.587G + 0.114B
    final double luminance =
        (0.299 * backgroundColor.r * 255.0 +
            0.587 * backgroundColor.g * 255.0 +
            0.114 * backgroundColor.b * 255.0) /
        255;

    // If luminance is high (light color), use black; otherwise, use white
    return luminance > 0.5 ? Colors.black : Colors.white;
  }

  /// Build column for a team (top or bottom)
  Widget _buildTeamColumn(
    BuildContext context, {
    required List<String> plan,
    required List<FixturePlayerInfo> players,
    required Color primaryColor,
    required Color numberColor,
    required bool isReversed,
    required int Function() lineIndex,
  }) {
    return Column(
      mainAxisAlignment:
          isReversed
              ? MainAxisAlignment.spaceAround
              : MainAxisAlignment.spaceEvenly,
      children: [
        if (!isReversed)
          _buildPlayer(context, players.first, primaryColor, numberColor),
        ListView.separated(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: plan.length,
          separatorBuilder: (_, _) => SizedBox(height: 10.height),
          itemBuilder: (_, index) {
            /// Generates a list of [FixturePlayerInfo] objects representing the players in a specific line,
            /// based on the number of players specified by `plan.elementAt(index)`.
            ///
            /// - Parses the number of players for the current line from the `plan`.
            /// - Uses [List.generate] to create a list of players by repeatedly calling `lineIndex()`
            ///   to get the appropriate index from the `players` list.
            /// - Reverses the order of the players in the line.
            final numPlayers = int.parse(plan.elementAt(index));
            List<FixturePlayerInfo> linePlayers = List.generate(numPlayers, (
              _,
            ) {
              final idx = lineIndex();
              return players[idx];
            });
            linePlayers = linePlayers.reversed.toList();
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:
                  linePlayers.map((player) {
                    return Expanded(
                      child: _buildPlayer(
                        context,
                        player,
                        primaryColor,
                        numberColor,
                      ),
                    );
                  }).toList(),
            );
          },
        ),
        if (isReversed)
          _buildPlayer(context, players.last, primaryColor, numberColor),
      ],
    );
  }

  /// Common player widget
  Widget _buildPlayer(
    BuildContext context,
    FixturePlayerInfo player,
    Color primaryColor,
    Color numberColor,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 13.radius,
            backgroundColor: AppColors.white,
            child: CircleAvatar(
              radius: 11.radius,
              backgroundColor: primaryColor,
              child: Text(
                player.player.number.toString(),
                style: Theme.of(
                  context,
                ).textTheme.labelMedium?.copyWith(color: numberColor),
              ),
            ),
          ),
          SizedBox(height: 2.height),
          Text(
            player.player.name.playerName,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.labelMedium?.copyWith(color: AppColors.white),
          ),
        ],
      ),
    );
  }
}
