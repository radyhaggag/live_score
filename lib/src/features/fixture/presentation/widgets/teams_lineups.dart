import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:live_score/src/core/extensions/color.dart';

import '../../domain/entities/fixture_details.dart';
import 'lineup_player.dart';

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

    final homeColor =
        ('#${homeTeam.color ?? homeTeam.awayColor ?? "1E5631"}').toColor;
    final awayColor =
        ('#${awayTeam.color ?? awayTeam.awayColor ?? "FFFFFF"}').toColor;

    return Column(
      children: [
        Expanded(
          child: _LineupTeamColumn(
            plan: homePlan ?? const [],
            players: homePlayers,
            primaryColor: homeColor,
            numberColor: _contrastColor(homeColor),
            isReversed: false,
          ),
        ),
        Expanded(
          child: _LineupTeamColumn(
            plan: awayPlan ?? const [],
            players: awayPlayers,
            primaryColor: awayColor,
            numberColor: _contrastColor(awayColor),
            isReversed: true,
          ),
        ),
      ],
    );
  }

  Color _contrastColor(Color backgroundColor) {
    final double luminance =
        (0.299 * backgroundColor.r * 255.0 +
            0.587 * backgroundColor.g * 255.0 +
            0.114 * backgroundColor.b * 255.0) /
        255;
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}

class _LineupTeamColumn extends StatelessWidget {
  const _LineupTeamColumn({
    required this.plan,
    required this.players,
    required this.primaryColor,
    required this.numberColor,
    required this.isReversed,
  });

  final List<String> plan;
  final List<FixturePlayerInfo> players;
  final Color primaryColor;
  final Color numberColor;
  final bool isReversed;

  @override
  Widget build(BuildContext context) {
    if (players.isEmpty) return const SizedBox.shrink();

    int lineIndex = isReversed ? -1 : 0;
    final columnChildren = <Widget>[];

    if (!isReversed) {
      columnChildren.add(
        LineupPlayer(
          player: players.first,
          primaryColor: primaryColor,
          numberColor: numberColor,
        ),
      );
    }

    for (final line in plan) {
      final numPlayers = int.tryParse(line) ?? 0;
      if (numPlayers <= 0) continue;

      final linePlayers =
          List.generate(numPlayers, (_) {
            lineIndex++;
            return players[lineIndex.clamp(0, players.length - 1)];
          }).reversed.toList();

      columnChildren.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:
              linePlayers
                  .map(
                    (player) => Expanded(
                      child: LineupPlayer(
                        player: player,
                        primaryColor: primaryColor,
                        numberColor: numberColor,
                      ),
                    ),
                  )
                  .toList(),
        ),
      );
    }

    if (isReversed) {
      columnChildren.add(
        LineupPlayer(
          player: players.last,
          primaryColor: primaryColor,
          numberColor: numberColor,
        ),
      );
    }

    final animatedChildren = <Widget>[];
    for (int i = 0; i < columnChildren.length; i++) {
      animatedChildren.add(
        columnChildren[i]
            .animate()
            .fade(duration: 400.ms, delay: (100 * i).ms)
            .slideY(begin: isReversed ? -0.1 : 0.1),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: animatedChildren,
    );
  }
}
