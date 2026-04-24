import 'package:equatable/equatable.dart';

import '../../../features/fixture/domain/entities/lineups.dart';

/// Represents the teams entity/model.
class Teams extends Equatable {
  final Team home;
  final Team away;

  const Teams({required this.home, required this.away});

  @override
  List<Object?> get props => [home, away];
}

/// Represents the team entity/model.
class Team extends Equatable {
  final int id;
  final String name;
  final String? shortName;
  final String logo;
  final int score;
  final int? aggregatedScore;
  final String? color;
  final String? awayColor;
  final Lineup? lineup;

  const Team({
    required this.id,
    required this.name,
    required this.logo,
    this.score = -1,
    this.aggregatedScore,
    this.color,
    this.awayColor,
    this.lineup,
    this.shortName,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    logo,
    color,
    awayColor,
    score,
    aggregatedScore,
    lineup,
    shortName,
  ];
}
