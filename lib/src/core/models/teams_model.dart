import 'package:live_score/src/core/constants/app_constants.dart';

import '../../features/fixture/data/models/lineups_model.dart';
import '../domain/entities/teams.dart';

/// Represents the teams model entity/model.
class TeamsModel extends Teams {
  const TeamsModel({required super.home, required super.away});

  factory TeamsModel.fromJson(Map<String, dynamic> json) => TeamsModel(
    home: TeamModel.fromJson(json['homeCompetitor']),
    away: TeamModel.fromJson(json['awayCompetitor']),
  );
}

/// Represents the team model entity/model.
class TeamModel extends Team {
  const TeamModel({
    required super.id,
    required super.name,
    required super.logo,
    super.color,
    super.awayColor,
    super.score,
    super.aggregatedScore,
    super.lineup,
    super.shortName,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    return TeamModel(
      id: id,
      name: json['name'],
      logo: AppConstants.clubImage(id.toString()),
      color: json['color'],
      awayColor: json['awayColor'],
      score: (json['score'] as num?)?.toInt() ?? -1,
      aggregatedScore: (json['aggregatedScore'] as num?)?.toInt(),
      shortName: json['shortName'],
      lineup:
          json['lineups'] != null
              ? LineupModel.fromJson(json['lineups'])
              : null,
    );
  }
}
