import 'package:flutter/foundation.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

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
