import 'package:equatable/equatable.dart';

import 'team_rank.dart';

class Standings extends Equatable {
  final List<List<TeamRank>> standings;

  const Standings({required this.standings});

  @override
  List<Object?> get props => [standings];
}
