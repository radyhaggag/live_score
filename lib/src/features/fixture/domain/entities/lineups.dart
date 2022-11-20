import 'package:equatable/equatable.dart';

import 'lineup_team.dart';
import 'player.dart';

class Lineup extends Equatable {
  final LineupTeam team;
  final String coachName;
  final String formation;
  final List<Player> startXI;
  final List<Player> substitutes;

  const Lineup({
    required this.team,
    required this.coachName,
    required this.formation,
    required this.startXI,
    required this.substitutes,
  });

  @override
  List<Object?> get props => [team, coachName, formation, startXI, substitutes];
}
