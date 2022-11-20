import '../domain/entities/teams.dart';
import '../domain/mappers/mappers.dart';

class TeamsModel extends Teams {
  const TeamsModel({
    required Team home,
    required Team away,
  }) : super(home: home, away: away);

  factory TeamsModel.fromJson(Map<String, dynamic> json) => TeamsModel(
        home: TeamModel.fromJson(json['home']).toDomain(),
        away: TeamModel.fromJson(json['away']).toDomain(),
      );
}

class TeamModel extends Team {
  const TeamModel({
    required int id,
    required String name,
    required String logo,
    required bool? winner,
  }) : super(id: id, name: name, logo: logo, winner: winner);

  factory TeamModel.fromJson(Map<String, dynamic> json) => TeamModel(
        id: json['id'],
        name: json['name'],
        logo: json['logo'],
        winner: json['winner'],
      );
}
