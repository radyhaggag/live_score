import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/domain/entities/league.dart';
import '../../../../core/domain/entities/soccer_fixture.dart';
import '../../../../core/domain/mappers/mappers.dart';
import '../../../../core/error/error_handler.dart';
import '../../../../core/error/response_status.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/standings.dart';
import '../../domain/repositories/soccer_repository.dart';
import '../../domain/use_cases/standings_usecase.dart';
import '../datasources/soccer_data_source.dart';

class SoccerRepositoryImpl implements SoccerRepository {
  final SoccerDataSource soccerDataSource;
  final NetworkInfo networkInfo;

  SoccerRepositoryImpl({
    required this.soccerDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<SoccerFixture>>> getDayFixtures(
      {required String date}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await soccerDataSource.getDayFixtures(date: date);
        List<SoccerFixture> fixtures =
            result.map((fixture) => fixture.toDomain()).toList();
        return Right(fixtures);
      } on DioException catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.networkConnectError.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<League>>> getLeagues() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await soccerDataSource.getLeagues();
        List<League> leagues =
            result.map((league) => league.toDomain()).toList();
        return Right(leagues);
      } on DioException catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.networkConnectError.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<SoccerFixture>>> getLiveFixtures() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await soccerDataSource.getLiveFixtures();
        List<SoccerFixture> fixtures =
            result.map((fixture) => fixture.toDomain()).toList();
        return Right(fixtures);
      } on DioException catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.networkConnectError.getFailure());
    }
  }

  @override
  Future<Either<Failure, Standings>> getStandings(
      {required StandingsParams params}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await soccerDataSource.getStandings(params: params);
        Standings standings = result;
        return Right(standings);
      } on DioException catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.networkConnectError.getFailure());
    }
  }
}
