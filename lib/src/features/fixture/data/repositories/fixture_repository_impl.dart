import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/error/error_handler.dart';
import '../../../../core/network/network_info.dart';
import '../data_sources/fixture_data_source.dart';
import '../../domain/entities/events.dart';
import '../../domain/entities/lineups.dart';
import '../../domain/entities/statistics.dart';
import '../../domain/mappers/mappers.dart';
import '../../domain/repositories/fixture_repository.dart';
import '../../../../core/error/response_status.dart';

class FixtureRepositoryImpl implements FixtureRepository {
  final NetworkInfo networkInfo;
  final FixtureDataSource fixtureDataSource;

  FixtureRepositoryImpl(
      {required this.networkInfo, required this.fixtureDataSource});

  @override
  Future<Either<Failure, List<Event>>> getEvents(String fixtureId) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await fixtureDataSource.getEvents(fixtureId);
        List<Event> events = result.map((event) => event.toDomain()).toList();
        return Right(events);
      } on DioException catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.networkConnectError.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<Lineup>>> getLineups(String fixtureId) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await fixtureDataSource.getLineups(fixtureId);
        List<Lineup> lineups =
            result.map((lineup) => lineup.toDomain()).toList();
        return Right(lineups);
      } on DioException catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.networkConnectError.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<Statistics>>> getStatistics(
      String fixtureId) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await fixtureDataSource.getStatistics(fixtureId);
        List<Statistics> statistics =
            result.map((statistic) => statistic.toDomain()).toList();
        return Right(statistics);
      } on DioException catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.networkConnectError.getFailure());
    }
  }
}
