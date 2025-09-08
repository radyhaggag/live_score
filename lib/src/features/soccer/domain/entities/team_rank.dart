import 'package:equatable/equatable.dart';

import '../../../../core/domain/entities/teams.dart';

class TeamRank extends Equatable {
  final int rank;
  final Team team;
  final int points;
  final int goalsDiff;
  final List<int> form;
  final TeamRankStats stats;

  const TeamRank({
    required this.rank,
    required this.team,
    required this.points,
    required this.goalsDiff,
    this.form = const [],
    required this.stats,
  });

  @override
  List<Object?> get props => [rank, team, points, goalsDiff, form, stats];
}

class TeamRankStats extends Equatable {
  final int played;
  final int win;
  final int draw;
  final int lose;
  final int scored;
  final int received;

  const TeamRankStats({
    required this.played,
    required this.win,
    required this.draw,
    required this.lose,
    required this.scored,
    required this.received,
  });

  @override
  List<Object?> get props => [played, win, draw, lose, scored, received];
}
