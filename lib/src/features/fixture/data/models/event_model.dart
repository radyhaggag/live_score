import '../../../../core/domain/entities/teams.dart';
import '../../../../core/domain/mappers/mappers.dart';
import '../../../../core/models/teams_model.dart';
import '../../domain/entities/events.dart';

class EventModel extends Event {
  const EventModel(
      {required int time,
      required Team team,
      required String playerName,
      required String assistName,
      required String type,
      required String detail})
      : super(
            time: time,
            team: team,
            playerName: playerName,
            assistName: assistName,
            type: type,
            detail: detail);

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        time: json["time"]["elapsed"],
        team: TeamModel.fromJson(json["team"]).toDomain(),
        playerName: json["player"]["name"] ?? "",
        assistName: json["assist"]["name"] ?? "No assist",
        type: json["type"],
        detail: json["detail"],
      );
}
