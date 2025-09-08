import 'package:live_score/src/core/utils/app_constants.dart';

import '../domain/entities/teams.dart';
import '../domain/mappers/mappers.dart';

class TeamsModel extends Teams {
  const TeamsModel({required super.home, required super.away});

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
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    return TeamModel(
      id: id,
      name: json['name'],
      logo: AppConstants.clubImage(id.toString()),
    );
  }
}
