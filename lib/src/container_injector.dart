import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'core/api/dio_helper.dart';
import 'core/api/interceptors.dart';
import 'core/network/network_info.dart';
import 'features/fixture/fixture_injector.dart';
import 'features/soccer/soccer_injector.dart';

final sl = GetIt.instance;

void initApp() {
  initCore();
  initSoccer();
  initFixture();
}

void initCore() {
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<AppInterceptors>(() => AppInterceptors());

  sl.registerLazySingleton<LogInterceptor>(() {
    return LogInterceptor(
      error: kDebugMode,
      request: kDebugMode,
      requestBody: kDebugMode,
      requestHeader: kDebugMode,
      responseBody: kDebugMode,
      responseHeader: kDebugMode,
    );
  });
  sl.registerLazySingleton<DioHelper>(() => DioHelper(dio: sl<Dio>()));
  sl.registerLazySingleton<InternetConnectionChecker>(
    () => InternetConnectionChecker.createInstance(
      addresses: [
        AddressCheckOption(uri: Uri.parse('https://www.google.com')),
        AddressCheckOption(uri: Uri.parse('https://www.bing.com')),
        AddressCheckOption(uri: Uri.parse('https://www.amazon.com')),
      ],
    ),
  );
  sl.registerLazySingleton<NetworkInfoImpl>(
    () => NetworkInfoImpl(connectionChecker: sl<InternetConnectionChecker>()),
  );
}
