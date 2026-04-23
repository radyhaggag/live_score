import 'package:dartz/dartz.dart';
import 'package:live_score/src/features/fixture/domain/entities/fixture_details.dart';

import '../../../../core/error/error_handler.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/utils/safe_api_call.dart';
import '../../domain/entities/statistics.dart';
import '../../domain/repositories/fixture_repository.dart';
import '../data_sources/fixture_data_source.dart';

class FixtureRepositoryImpl implements FixtureRepository {
  final NetworkInfo networkInfo;
  final FixtureDataSource fixtureDataSource;

  FixtureRepositoryImpl({
    required this.networkInfo,
    required this.fixtureDataSource,
  });

  @override
  Future<Either<Failure, FixtureDetails>> getFixtureDetails(int fixtureId) {
    return safeApiCall(networkInfo, () async {
      return await fixtureDataSource.getFixtureDetails(fixtureId);
    });
  }

  @override
  Future<Either<Failure, Statistics>> getStatistics(int fixtureId) {
    return safeApiCall(networkInfo, () async {
      return await fixtureDataSource.getStatistics(fixtureId);
    });
  }
}
