import 'package:dartz/dartz.dart';

import '../../../../core/error/error_handler.dart';
import '../entities/fixture_details.dart';
import '../entities/statistics.dart';

/// Represents the fixture repository entity/model.
abstract class FixtureRepository {
  /// Get statistics.
  Future<Either<Failure, Statistics>> getStatistics(int fixtureId);

  /// Get fixture details.
  Future<Either<Failure, FixtureDetails>> getFixtureDetails(int fixtureId);
}
