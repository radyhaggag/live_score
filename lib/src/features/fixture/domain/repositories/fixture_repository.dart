import 'package:dartz/dartz.dart';
import '../../../../core/error/error_handler.dart';
import '../entities/events.dart';
import '../entities/lineups.dart';
import '../entities/statistics.dart';

abstract class FixtureRepository {
  Future<Either<Failure, List<Statistics>>> getStatistics(String fixtureId);

  Future<Either<Failure, List<Lineup>>> getLineups(String fixtureId);

  Future<Either<Failure, List<Event>>> getEvents(String fixtureId);
}
