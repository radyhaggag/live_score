import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import 'response_status.dart';

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioError) {
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

Failure _handleError(DioError error) {
  switch (error.type) {
    case DioErrorType.connectTimeout:
    case DioErrorType.sendTimeout:
    case DioErrorType.receiveTimeout:
      return DataSource.networkConnectError.getFailure();
    case DioErrorType.response:
      switch (error.response?.statusCode) {
        case StatusCode.internalServerError:
          return DataSource.internalServerError.getFailure();
        case StatusCode.clientClosedRequest:
          return DataSource.clientClosedRequest.getFailure();
        default:
          return DataSource.unexpected.getFailure();
      }
    case DioErrorType.cancel:
    case DioErrorType.other:
      return DataSource.unexpected.getFailure();
  }
}
