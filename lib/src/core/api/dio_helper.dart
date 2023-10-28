import 'package:dio/dio.dart';

import '../../container_injector.dart';
import '../utils/app_constants.dart';
import 'interceptors.dart';

const String _contentType = "Content-Type";
const String _applicationJson = "application/json";
const String _apiKey =
    "59e59ee6171e8f9a4960bed9e46c4003"; // Add your api key here
const int _timeOut = 20000;

class DioHelper {
  final Dio dio;

  DioHelper({required this.dio}) {
    Map<String, dynamic> headers = {
      _contentType: _applicationJson,
      'x-rapidapi-host': 'v3.football.api-sports.io',
      'x-rapidapi-key': _apiKey,
    };
    dio.options = BaseOptions(
      baseUrl: AppConstants.baseUrl,
      receiveDataWhenStatusError: true,
      receiveTimeout: const Duration(milliseconds: _timeOut),
      connectTimeout: const Duration(milliseconds: _timeOut),
      headers: headers,
    );
    dio.interceptors.add(sl<LogInterceptor>());
    dio.interceptors.add(sl<AppInterceptors>());
  }

  Future<Response> get({
    required String url,
    Map<String, dynamic>? queryParams,
  }) async {
    return await dio.get(url, queryParameters: queryParams);
  }
}
