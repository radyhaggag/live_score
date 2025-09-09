import 'package:live_score/src/core/domain/mappers/mappers.dart';
import 'package:live_score/src/core/models/league_model.dart';

import '../domain/entities/soccer_fixture.dart';
import 'teams_model.dart';

class SoccerFixtureModel extends SoccerFixture {
  const SoccerFixtureModel({
    required super.id,
    required super.teams,
    required super.statusText,
    required super.gameTimeAndStatusDisplayType,
    required super.fixtureLeague,
    super.startTime,
    super.gameTime,
    super.addedTime,
    super.gameTimeDisplay = '',
    super.roundNum,
    super.stageNum,
    super.seasonNum,
  });

  factory SoccerFixtureModel.fromJson(
    Map<String, dynamic> json, {
    required LeagueModel fixtureLeague,
  }) => SoccerFixtureModel(
    id: json['id'],
    teams: TeamsModel.fromJson(json).toDomain(),
    fixtureLeague: fixtureLeague,
    statusText: json['statusText'],
    gameTimeAndStatusDisplayType:
        (json['gameTimeAndStatusDisplayType'] as num).toInt(),
    startTime: DateTime.parse(json['startTime']),
    gameTime: (json['gameTime'] as num?)?.toInt(),
    addedTime: (json['addedTime'] as num?)?.toInt(),
    gameTimeDisplay: json['gameTimeDisplay'] ?? '',
    roundNum: json['roundNum'],
    stageNum: json['stageNum'],
    seasonNum: json['seasonNum'],
  );
}
