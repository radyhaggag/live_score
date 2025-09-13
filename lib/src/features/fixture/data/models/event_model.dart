import '../../../../core/utils/parsers.dart';
import '../../domain/entities/event.dart';

class EventModel extends Event {
  const EventModel({
    required super.teamId,
    required super.playerId,
    required super.order,
    required super.gameTime,
    required super.addedTime,
    required super.gameTimeDisplay,
    required super.gameTimeAndStatusDisplayType,
    required super.type,
    super.extraPlayers,
    super.player,
    super.team,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      teamId: toInt(json['competitorId']) ?? 0,
      playerId: toInt(json['playerId']) ?? 0,
      order: toInt(json['order']) ?? 0,
      gameTime: toInt(json['gameTime']) ?? 0,
      addedTime: toInt(json['addedTime']) ?? 0,
      gameTimeDisplay: json['gameTimeDisplay'] ?? '',
      gameTimeAndStatusDisplayType: json['gameTimeAndStatusDisplayType'] ?? '',
      type: EventTypeModel.fromJson(json['eventType']),
      extraPlayers:
          (json['extraPlayers'] as List<dynamic>?)
              ?.map((e) => toInt(e) ?? 0)
              .toList() ??
          [],
    );
  }
}

class EventTypeModel extends EventType {
  const EventTypeModel({
    required super.id,
    required super.name,
    required super.subTypeId,
    super.subTypeName,
  });

  factory EventTypeModel.fromJson(Map<String, dynamic> json) {
    return EventTypeModel(
      id: EventId.fromValue(toInt(json['id']) ?? -1) ?? EventId.none,
      name: json['name'] ?? '',
      subTypeId: toInt(json['subTypeId']) ?? -1,
      subTypeName: json['subTypeName'],
    );
  }
}
