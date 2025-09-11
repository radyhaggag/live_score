import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:live_score/src/features/fixture/domain/entities/fixture_details.dart';

import '../../../../core/error/error_handler.dart';
import '../../../../core/error/response_status.dart';
import '../../../../core/network/network_info.dart';
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
  Future<Either<Failure, FixtureDetails>> getFixtureDetails(
    int fixtureId,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await fixtureDataSource.getFixtureDetails(fixtureId);
        return Right(result);
      } on DioException catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.networkConnectError.getFailure());
    }
  }

  @override
  Future<Either<Failure, Statistics>> getStatistics(int fixtureId) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await fixtureDataSource.getStatistics(fixtureId);
        return Right(result);
      } on DioException catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.networkConnectError.getFailure());
    }
  }
}
