import 'error_handler.dart';

enum DataSource {
  clientClosedRequest,
  internalServerError,
  networkConnectError,
  webProxyRequired,
  unexpected,
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.clientClosedRequest:
        return const Failure(
          code: StatusCode.clientClosedRequest,
          message: StatusMessage.clientClosedRequestKey,
        );
      case DataSource.internalServerError:
        return const Failure(
          code: StatusCode.internalServerError,
          message: StatusMessage.internalServerErrorKey,
        );
      case DataSource.networkConnectError:
        return const Failure(
          code: StatusCode.networkConnectError,
          message: StatusMessage.networkConnectErrorKey,
        );
      case DataSource.webProxyRequired:
        return const Failure(
          code: StatusCode.webProxyRequired,
          message: StatusMessage.webProxyRequiredKey,
        );
      case DataSource.unexpected:
        return const Failure(
          code: StatusCode.unexpected,
          message: StatusMessage.unexpectedKey,
        );
    }
  }
}

class StatusCode {
  static const int clientClosedRequest = 499;
  static const int internalServerError = 500;
  static const int networkConnectError = 599;
  static const int webProxyRequired = 601;
  static const int unexpected = -1;
}

class StatusMessage {
  static const String clientClosedRequestKey = 'error.clientClosedRequest';
  static const String internalServerErrorKey = 'error.internalServerError';
  static const String networkConnectErrorKey = 'error.networkConnectError';
  static const String webProxyRequiredKey = 'error.webProxyRequired';
  static const String unexpectedKey = 'error.unexpected';
}
