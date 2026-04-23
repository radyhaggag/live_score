import 'package:flutter/foundation.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

/// Represents the network info entity/model.
abstract class NetworkInfo {
  Future<bool> get isConnected;
}

/// Represents the network info impl entity/model.
class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker? connectionChecker;

  NetworkInfoImpl({this.connectionChecker});

  @override
  Future<bool> get isConnected async {
    if (kIsWeb) {
      return true;
    }

    try {
      final checker = connectionChecker;
      if (checker == null) return true;
      return await checker.hasConnection;
    } catch (_) {
      return true;
    }
  }
}
