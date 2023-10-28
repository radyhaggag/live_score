import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import 'response_status.dart';

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      failure = _handleError(error);
    } else {
      failure = DataSource.unexpected.getFailure();
    }
  }
}

class Failure extends Equatable {
  final int code;
  final String message;

  const Failure({required this.code, required this.message});

  @override
  List<Object?> get props => [code, message];
}

Failure _handleError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.connectionError:
      return DataSource.networkConnectError.getFailure();
    case DioExceptionType.badResponse:
      switch (error.response?.statusCode) {
        case StatusCode.internalServerError:
          return DataSource.internalServerError.getFailure();
        case StatusCode.clientClosedRequest:
          return DataSource.clientClosedRequest.getFailure();
        default:
          return DataSource.unexpected.getFailure();
      }
    case DioExceptionType.cancel:
    case DioExceptionType.unknown:
    case DioExceptionType.badCertificate:
      return DataSource.unexpected.getFailure();
  }
}
