import '../../../../core/domain/mappers/mappers.dart';
import '../../../../core/models/teams_model.dart';
import '../../domain/entities/events.dart';

class EventModel extends Event {
  const EventModel(
      {required super.time,
      required super.team,
      required super.playerName,
      required super.assistName,
      required super.type,
      required super.detail});

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        time: json["time"]["elapsed"],
        team: TeamModel.fromJson(json["team"]).toDomain(),
        playerName: json["player"]["name"] ?? "",
        assistName: json["assist"]["name"] ?? "No assist",
        type: json["type"],
        detail: json["detail"],
      );
}
