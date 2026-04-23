import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:live_score/src/core/extensions/strings.dart';

import '../../../../core/utils/app_colors.dart';
import '../../domain/entities/fixture_details.dart';

class TeamsLineups extends StatelessWidget {
  final FixtureDetails fixtureDetails;

  const TeamsLineups({
    super.key,
    required this.fixtureDetails,
  });

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

    return _buildVertical(
      context,
      homePlan: homePlan ?? const [],
      awayPlan: awayPlan ?? const [],
      homePlayers: homePlayers,
      awayPlayers: awayPlayers,
      homeTeam: homeTeam,
      awayTeam: awayTeam,
    );
  }

  Widget _buildVertical(
    BuildContext context, {
    required List<String> homePlan,
    required List<String> awayPlan,
    required List<FixturePlayerInfo> homePlayers,
    required List<FixturePlayerInfo> awayPlayers,
    required dynamic homeTeam,
    required dynamic awayTeam,
  }) {
    int lineOneIndex = 0;
    int lineTwoIndex = -1;

    return Column(
      children: [
        Expanded(
          child: _buildTeamColumn(
            context,
            plan: homePlan,
            players: homePlayers,
            primaryColor: HexColor('#${homeTeam.awayColor ?? homeTeam.color}'),
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
            plan: awayPlan,
            players: awayPlayers,
            primaryColor: HexColor('#${awayTeam.color ?? awayTeam.awayColor}'),
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

  Color getContrastingNumberColor(Color backgroundColor) {
    final double luminance =
        (0.299 * backgroundColor.r * 255.0 +
            0.587 * backgroundColor.g * 255.0 +
            0.114 * backgroundColor.b * 255.0) /
        255;

    return luminance > 0.5 ? Colors.black : Colors.white;
  }

  Widget _buildTeamColumn(
    BuildContext context, {
    required List<String> plan,
    required List<FixturePlayerInfo> players,
    required Color primaryColor,
    required Color numberColor,
    required bool isReversed,
    required int Function() lineIndex,
    bool compactSpacing = false,
  }) {
    final columnChildren = <Widget>[];

    if (players.isEmpty) {
      return const SizedBox.shrink();
    }

    if (!isReversed) {
      columnChildren.add(
        _buildPlayer(context, players.first, primaryColor, numberColor),
      );
    }

    for (final line in plan) {
      final numPlayers = int.tryParse(line) ?? 0;
      if (numPlayers <= 0) continue;
      List<FixturePlayerInfo> linePlayers = List.generate(numPlayers, (_) {
        final idx = lineIndex();
        return players[idx.clamp(0, players.length - 1)];
      });
      linePlayers = linePlayers.reversed.toList();

      columnChildren.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:
              linePlayers.map((player) {
                return Expanded(
                  child: _buildPlayer(
                    context,
                    player,
                    primaryColor,
                    numberColor,
                    compact: compactSpacing,
                  ),
                );
              }).toList(),
        ),
      );
    }

    if (isReversed) {
      columnChildren.add(
        _buildPlayer(context, players.last, primaryColor, numberColor),
      );
    }

    return Column(
      mainAxisAlignment:
          compactSpacing
              ? MainAxisAlignment.spaceEvenly
              : (isReversed
                  ? MainAxisAlignment.spaceAround
                  : MainAxisAlignment.spaceEvenly),
      children: columnChildren,
    );
  }

  Widget _buildPlayer(
    BuildContext context,
    FixturePlayerInfo player,
    Color primaryColor,
    Color numberColor, {
    bool compact = false,
  }) {
    final outerRadius = compact ? 12.0 : 13.0;
    final innerRadius = compact ? 10.0 : 11.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: outerRadius,
            backgroundColor: AppColors.white,
            child: CircleAvatar(
              radius: innerRadius,
              backgroundColor: primaryColor,
              child: Text(
                player.player.number.toString(),
                style: Theme.of(
                  context,
                ).textTheme.labelSmall?.copyWith(color: numberColor),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            player.player.name.playerName,
            textAlign: TextAlign.center,
            maxLines: compact ? 1 : 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(
              context,
            ).textTheme.labelSmall?.copyWith(color: AppColors.white),
          ),
        ],
      ),
    );
  }
}
