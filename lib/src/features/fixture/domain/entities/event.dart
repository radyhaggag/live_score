// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:live_score/src/core/domain/entities/teams.dart';
import 'package:live_score/src/features/fixture/domain/entities/player.dart';

class Event extends Equatable {
  final int teamId;
  final int playerId;
  final int order;
  final int gameTime;
  final int addedTime;
  final String gameTimeDisplay;
  final int gameTimeAndStatusDisplayType;
  final EventType type;
  final List<int> extraPlayers;

  // For UI
  final Player? player;
  final Team? team;
  final List<Player>? extraPlayerDetails;

  const Event({
    required this.teamId,
    required this.playerId,
    required this.order,
    required this.gameTime,
    required this.addedTime,
    required this.gameTimeDisplay,
    required this.gameTimeAndStatusDisplayType,
    required this.type,
    this.extraPlayers = const [],
    this.player,
    this.team,
    this.extraPlayerDetails,
  });

  @override
  List<Object?> get props => [
    teamId,
    playerId,
    order,
    gameTime,
    addedTime,
    gameTimeDisplay,
    gameTimeAndStatusDisplayType,
    type,
  ];

  Event copyWith({
    int? teamId,
    int? playerId,
    int? order,
    int? gameTime,
    int? addedTime,
    String? gameTimeDisplay,
    int? gameTimeAndStatusDisplayType,
    EventType? type,
    Player? player,
    Team? team,
    List<Player>? extraPlayerDetails,
  }) {
    return Event(
      teamId: teamId ?? this.teamId,
      playerId: playerId ?? this.playerId,
      order: order ?? this.order,
      gameTime: gameTime ?? this.gameTime,
      addedTime: addedTime ?? this.addedTime,
      gameTimeDisplay: gameTimeDisplay ?? this.gameTimeDisplay,
      gameTimeAndStatusDisplayType:
          gameTimeAndStatusDisplayType ?? this.gameTimeAndStatusDisplayType,
      type: type ?? this.type,
      player: player ?? this.player,
      team: team ?? this.team,
      extraPlayerDetails: extraPlayerDetails ?? this.extraPlayerDetails,
    );
  }
}

class EventType {
  final EventId id;
  final String name;
  final int subTypeId;
  final String? subTypeName;

  const EventType({
    required this.id,
    required this.name,
    required this.subTypeId,
    this.subTypeName,
  });
}

enum EventId {
  goal(1),
  cardYellow(2),
  cardRed(3),
  missedPenalty(6),
  substitute(1000),
  none(-1);

  final int value;
  const EventId(this.value);

  static EventId? fromValue(int value) {
    return EventId.values.firstWhere(
      (e) => e.value == value,
      orElse: () => EventId.none,
    );
  }

  bool get isYellowCard => this == EventId.cardYellow;
  bool get isRedCard => this == EventId.cardRed;
  bool get isSubstitute => this == EventId.substitute;
  bool get isMissedPenalty => this == EventId.missedPenalty;

  bool get isGoalOrOwnGoal => this == EventId.goal;
  bool get isCard => this == EventId.cardYellow || this == EventId.cardRed;

  bool isGoal(int? subTypeId) => this == EventId.goal && subTypeId == 1;
  bool isOwnGoal(int? subTypeId) => this == EventId.goal && subTypeId == 2;
}
