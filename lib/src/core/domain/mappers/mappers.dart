import '../../models/goals_model.dart';
import '../../models/league_model.dart';
import '../../models/soccer_fixture_model.dart';
import '../../models/status_model.dart';
import '../../models/teams_model.dart';
import '../entities/goals.dart';
import '../entities/league.dart';
import '../entities/soccer_fixture.dart';
import '../entities/status.dart';
import '../entities/teams.dart';

extension StatusExtension on StatusModel {
  Status toDomain() => Status(long: long, short: short, elapsed: elapsed);
}

extension TeamExtension on TeamModel {
  Team toDomain() => Team(
    id: id,
    name: name,
    logo: logo,
    color: color,
    awayColor: awayColor,
    score: score,
    aggregatedScore: aggregatedScore,
  );
}

extension TeamsExtension on TeamsModel {
  Teams toDomain() => Teams(home: home, away: away);
}

extension GoalsExtension on GoalsModel {
  Goals toDomain() => Goals(home: home, away: away);
}

extension SoccerFixtureExtension on SoccerFixtureModel {
  SoccerFixture toDomain() => SoccerFixture(
    id: id,
    fixtureLeague: fixtureLeague,
    teams: teams,
    statusText: statusText,
    startTime: startTime,
    gameTime: gameTime,
    roundNum: roundNum,
    stageNum: stageNum,
    seasonNum: seasonNum,
  );
}

extension LeagueExtension on LeagueModel {
  League toDomain() {
    return League(
      id: id,
      name: name,
      logo: logo,
      countryId: countryId,
      country: country,
      hexColor: hexColor,
    );
  }
}
