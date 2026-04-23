import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../constants/app_constants.dart';
import 'response_status.dart';

/// Represents the error handler entity/model.
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

/// Represents the failure entity/model.
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
      if (kIsWeb && !AppConstants.isUsingWebProxy) {
        return DataSource.webProxyRequired.getFailure();
      }
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
