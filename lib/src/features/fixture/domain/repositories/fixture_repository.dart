import 'package:dartz/dartz.dart';

import '../../../../core/error/error_handler.dart';
import '../entities/fixture_details.dart';
import '../entities/statistics.dart';

abstract class FixtureRepository {
  Future<Either<Failure, Statistics>> getStatistics(int fixtureId);

  Future<Either<Failure, FixtureDetails>> getFixtureDetails(int fixtureId);
}
