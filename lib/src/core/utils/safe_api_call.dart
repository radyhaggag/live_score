import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../error/error_handler.dart';
import '../error/response_status.dart';
import '../network/network_info.dart';

/// Encapsulates the repeated try/catch + network-check pattern used
/// across all repository implementations.
///
/// Usage:
/// ```dart
/// Future<Either<Failure, List<League>>> getLeagues() {
///   return safeApiCall(networkInfo, () async {
///     final result = await dataSource.getLeagues();
///     return result.map((e) => e.toDomain()).toList();
///   });
/// }
/// ```
Future<Either<Failure, T>> safeApiCall<T>(
  NetworkInfo networkInfo,
  Future<T> Function() call,
) async {
  if (await networkInfo.isConnected) {
    try {
      final result = await call();
      return Right(result);
    } on DioException catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  } else {
    return Left(DataSource.networkConnectError.getFailure());
  }
}
