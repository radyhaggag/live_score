import '../domain/entities/soccer_fixture.dart';
import '../domain/mappers/mappers.dart';
import 'fixture_league.dart';
import 'fixture_model.dart';
import 'goals_model.dart';
import 'teams_model.dart';

class SoccerFixtureModel extends SoccerFixture {
  const SoccerFixtureModel(
      {required super.fixture,
      required super.fixtureLeague,
      required super.teams,
      required super.goals});

  factory SoccerFixtureModel.fromJson(Map<String, dynamic> json) =>
      SoccerFixtureModel(
        fixture: FixtureModel.fromJson(json['fixture']).toDomain(),
        fixtureLeague: FixtureLeagueModel.fromJson(json['league']).toDomain(),
        teams: TeamsModel.fromJson(json['teams']).toDomain(),
        goals: GoalsModel.fromJson(json['goals']).toDomain(),
      );
}
