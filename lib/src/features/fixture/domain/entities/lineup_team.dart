import 'package:equatable/equatable.dart';
import '../../../../core/domain/entities/teams.dart';

class LineupTeam extends Team {
  final LineupColors colors;

  const LineupTeam(
      {required super.id,
      required super.name,
      required super.logo,
      required this.colors});
}

class PlayerColors extends Equatable {
  final String primary;
  final String number;
  final String border;

  const PlayerColors(
      {required this.primary, required this.number, required this.border});

  @override
  List<Object?> get props => [primary, number, border];
}

class LineupColors extends Equatable {
  final PlayerColors player;
  final PlayerColors goalKeeper;

  const LineupColors({required this.player, required this.goalKeeper});

  @override
  List<Object?> get props => [player, goalKeeper];
}
