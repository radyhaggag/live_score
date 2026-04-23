import 'package:equatable/equatable.dart';

import 'team_rank.dart';

/// Represents the standings entity/model.
class Standings extends Equatable {
  final List<TeamRank> standings;
  final List<StandingsGroup>? groups;

  const Standings({required this.standings, this.groups});

  @override
  List<Object?> get props => [standings, groups];
}

/// Represents the standings group entity/model.
class StandingsGroup extends Equatable {
  final String name;
  final int number;

  const StandingsGroup({required this.name, required this.number});

  @override
  List<Object?> get props => [name, number];
}
