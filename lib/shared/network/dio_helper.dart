import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper {
  static String baseUrl = "https://v3.football.api-sports.io/";
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        headers: {
          "Content-Type": "application/json",
          'x-rapidapi-host': 'v3.football.api-sports.io',
          'x-rapidapi-key': "12b71bf44a8b400ea6e1ea46cdcbc4fb",
        },
      ),
    );
  }

  static Future<Response> getData({
    @required String? endPoint,
    Map<String, dynamic>? query,
  }) async {
    return await dio!.get(endPoint!, queryParameters: query);
  }
}
