import 'package:dartz/dartz.dart';

import '../../../../core/domain/entities/league.dart';
import '../../../../core/domain/entities/soccer_fixture.dart';
import '../../../../core/error/error_handler.dart';
import '../entities/standings.dart';
import '../use_cases/standings_usecase.dart';

abstract class SoccerRepository {
  Future<Either<Failure, List<League>>> getLeagues();

  Future<Either<Failure, List<SoccerFixture>>> getCurrentRoundFixtures({
    required int competitionId,
  });

  Future<Either<Failure, List<SoccerFixture>>> getTodayFixtures();

  Future<Either<Failure, Standings>> getStandings({
    required StandingsParams params,
  });
}
