import 'package:equatable/equatable.dart';

import '../../../../core/domain/entities/teams.dart';

class Statistics extends Equatable {
  final Team team;
  final List<Statistic> statistics;

  const Statistics({required this.team, required this.statistics});

  @override
  List<Object?> get props => [team, statistics];
}

class Statistic extends Equatable {
  final String type;
  final String value;

  const Statistic({required this.type, required this.value});

  @override
  List<Object?> get props => [type, value];
}
