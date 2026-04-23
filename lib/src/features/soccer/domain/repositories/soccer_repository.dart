import 'package:dartz/dartz.dart';

import '../../../../core/domain/entities/league.dart';
import '../../../../core/domain/entities/soccer_fixture.dart';
import '../../../../core/error/error_handler.dart';
import '../entities/standings.dart';
import '../use_cases/standings_usecase.dart';

/// Represents the soccer repository entity/model.
abstract class SoccerRepository {
  /// Get leagues.
  Future<Either<Failure, List<League>>> getLeagues();

  /// Get current round fixtures.
  Future<Either<Failure, List<SoccerFixture>>> getCurrentRoundFixtures({
    required int competitionId,
  });

  /// Get today fixtures.
  Future<Either<Failure, List<SoccerFixture>>> getTodayFixtures();

  /// Get standings.
  Future<Either<Failure, Standings>> getStandings({
    required StandingsParams params,
  });
}
