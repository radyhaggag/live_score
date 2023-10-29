import '../domain/entities/teams.dart';
import '../domain/mappers/mappers.dart';

class TeamsModel extends Teams {
  const TeamsModel({
    required super.home,
    required super.away,
  });

  factory TeamsModel.fromJson(Map<String, dynamic> json) => TeamsModel(
        home: TeamModel.fromJson(json['home']).toDomain(),
        away: TeamModel.fromJson(json['away']).toDomain(),
      );
}

class TeamModel extends Team {
  const TeamModel({
    required super.id,
    required super.name,
    required super.logo,
    required super.winner,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) => TeamModel(
        id: json['id'],
        name: json['name'],
        logo: json['logo'],
        winner: json['winner'],
      );
}
