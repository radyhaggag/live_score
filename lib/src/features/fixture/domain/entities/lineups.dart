import 'package:equatable/equatable.dart';

class Lineup extends Equatable {
  final String status;
  final String formation;
  final List<LineupMember> members;

  const Lineup({
    required this.status,
    required this.formation,
    required this.members,
  });

  @override
  List<Object?> get props => [status, formation, members];
}

class LineupMember extends Equatable {
  final int id;
  final int status;
  final String statusText;
  final YardInfo? yardInfo;

  const LineupMember({
    required this.id,
    required this.status,
    required this.statusText,
    this.yardInfo,
  });

  bool get isStarting => status == 1;
  bool get isSubstitute => status == 2;
  bool get isCoach => status == 4;

  @override
  List<Object?> get props => [id, status, statusText, yardInfo];
}

class YardInfo extends Equatable {
  final int line;
  final int fieldPosition;
  final int? fieldLine;
  final int? fieldSide;

  const YardInfo({
    required this.line,
    required this.fieldPosition,
    this.fieldLine,
    this.fieldSide,
  });

  @override
  List<Object?> get props => [line, fieldPosition, fieldLine, fieldSide];
}
