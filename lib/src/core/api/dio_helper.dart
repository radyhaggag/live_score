import 'package:dio/dio.dart';

import '../../container_injector.dart';
import '../utils/app_constants.dart';
import 'interceptors.dart';

const String _CONTENT_TYPE = "Content-Type";
const String _APPLICATION_JSON = "application/json";
const String _API_KEY = "12b71bf44a8b400ea6e1ea46cdcbc4fb";
const int TIMEOUT = 20000;

class DioHelper {
  final Dio dio;

  DioHelper({required this.dio}) {
    Map<String, dynamic> headers = {
      _CONTENT_TYPE: _APPLICATION_JSON,
      'x-rapidapi-host': 'v3.football.api-sports.io',
      'x-rapidapi-key': _API_KEY,
    };
    dio.options = BaseOptions(
      baseUrl: AppConstants.baseUrl,
      receiveDataWhenStatusError: true,
      receiveTimeout: TIMEOUT,
      connectTimeout: TIMEOUT,
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
