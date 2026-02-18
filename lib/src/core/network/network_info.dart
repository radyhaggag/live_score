import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker connectionChecker;

  NetworkInfoImpl({required this.connectionChecker});

  @override
  Future<bool> get isConnected async {
    final res = await connectionChecker.hasConnection;
    print('Network Connection Status: $res');
    return res;
  }
}
