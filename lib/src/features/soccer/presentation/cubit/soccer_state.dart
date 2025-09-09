import '../../../../core/domain/entities/league.dart';
import '../../../../core/domain/entities/soccer_fixture.dart';
import '../../domain/entities/standings.dart';

abstract class SoccerStates {}

class ScoreInitial extends SoccerStates {}

class SoccerLeaguesLoading extends SoccerStates {}

class SoccerLeaguesLoaded extends SoccerStates {
  final List<League> leagues;

  SoccerLeaguesLoaded(this.leagues);
}

class SoccerLeaguesLoadFailure extends SoccerStates {
  final String message;

  SoccerLeaguesLoadFailure(this.message);
}

class SoccerFixturesLoading extends SoccerStates {}

class SoccerFixturesLoaded extends SoccerStates {
  final List<SoccerFixture> fixtures;

  SoccerFixturesLoaded(this.fixtures);
}

class SoccerCurrentRoundFixturesLoaded extends SoccerStates {
  final List<SoccerFixture> fixtures;

  SoccerCurrentRoundFixturesLoaded(this.fixtures);
}

class SoccerFixturesLoadFailure extends SoccerStates {
  final String message;

  SoccerFixturesLoadFailure(this.message);
}

class SoccerTodayFixturesLoading extends SoccerStates {}

class SoccerTodayFixturesLoaded extends SoccerStates {
  final List<SoccerFixture> todayFixtures;
  final List<SoccerFixture> liveFixtures;

  SoccerTodayFixturesLoaded({
    required this.todayFixtures,
    required this.liveFixtures,
  });
}

class SoccerTodayFixturesLoadFailure extends SoccerStates {
  final String message;

  SoccerTodayFixturesLoadFailure(this.message);
}

class SoccerStandingsLoading extends SoccerStates {}

class SoccerStandingsLoaded extends SoccerStates {
  final Standings standings;

  SoccerStandingsLoaded(this.standings);
}

class SoccerStandingsLoadFailure extends SoccerStates {
  final String message;

  SoccerStandingsLoadFailure(this.message);
}
