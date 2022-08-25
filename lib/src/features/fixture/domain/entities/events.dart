import 'package:equatable/equatable.dart';

import '../../../../core/domain/entities/teams.dart';

class Event extends Equatable {
  final int time;
  final Team team;
  final String playerName;
  final String assistName;
  final String type;
  final String detail;

  const Event({
    required this.time,
    required this.team,
    required this.playerName,
    required this.assistName,
    required this.type,
    required this.detail,
  });

  @override
  List<Object?> get props => [time, team, playerName, assistName, type, detail];
}
