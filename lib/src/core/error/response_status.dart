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
          message: StatusMessage.clientClosedRequest,
        );
      case DataSource.internalServerError:
        return const Failure(
          code: StatusCode.internalServerError,
          message: StatusMessage.internalServerError,
        );
      case DataSource.networkConnectError:
        return const Failure(
          code: StatusCode.networkConnectError,
          message: StatusMessage.networkConnectError,
        );
      case DataSource.webProxyRequired:
        return const Failure(
          code: StatusCode.webProxyRequired,
          message: StatusMessage.webProxyRequired,
        );
      case DataSource.unexpected:
        return const Failure(
          code: StatusCode.unexpected,
          message: StatusMessage.unexpected,
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
  static const String clientClosedRequest =
      'Something went wrong while fetching details. Try again later.';
  static const String internalServerError =
      'Something went wrong. Try again later.';
  static const String networkConnectError =
      'Internet connection timeout. Try again later.';
  static const String webProxyRequired =
      'Flutter Web needs a server-side proxy for this API.';
  static const String unexpected = 'Unexpected Error.';
}
