import '../../../../../core/domain/entities/soccer_fixture.dart';
import '../../../domain/entities/standings.dart';

sealed class SoccerState {}

/// Represents the soccer initial entity/model.
class SoccerInitial extends SoccerState {}

/// Represents the soccer current round fixtures loading entity/model.
class SoccerCurrentRoundFixturesLoading extends SoccerState {}

/// Represents the soccer current round fixtures loaded entity/model.
class SoccerCurrentRoundFixturesLoaded extends SoccerState {
  final List<SoccerFixture> fixtures;

  SoccerCurrentRoundFixturesLoaded(this.fixtures);
}

/// Represents the soccer current round fixtures load failure entity/model.
class SoccerCurrentRoundFixturesLoadFailure extends SoccerState {
  final String message;
  final int? competitionId;

  SoccerCurrentRoundFixturesLoadFailure(this.message, {this.competitionId});
}

/// Represents the soccer today fixtures loading entity/model.
class SoccerTodayFixturesLoading extends SoccerState {
  final bool isTimerLoading;

  SoccerTodayFixturesLoading({this.isTimerLoading = false});
}

/// Represents the soccer today fixtures loaded entity/model.
class SoccerTodayFixturesLoaded extends SoccerState {
  final List<SoccerFixture> todayFixtures;
  final List<SoccerFixture> liveFixtures;

  SoccerTodayFixturesLoaded({
    required this.todayFixtures,
    required this.liveFixtures,
  });
}

/// Represents the soccer today fixtures load failure entity/model.
class SoccerTodayFixturesLoadFailure extends SoccerState {
  final String message;

  SoccerTodayFixturesLoadFailure(this.message);
}

/// Represents the soccer standings loading entity/model.
class SoccerStandingsLoading extends SoccerState {}

/// Represents the soccer standings loaded entity/model.
class SoccerStandingsLoaded extends SoccerState {
  final Standings standings;

  SoccerStandingsLoaded(this.standings);
}

/// Represents the soccer standings load failure entity/model.
class SoccerStandingsLoadFailure extends SoccerState {
  final String message;

  SoccerStandingsLoadFailure(this.message);
}
