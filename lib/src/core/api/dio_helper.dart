import 'dart:ui' as ui;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../container_injector.dart';
import '../../features/settings/presentation/cubit/settings_cubit.dart';
import '../utils/app_constants.dart';

const String _contentType = 'Content-Type';
const String _applicationJson = 'application/json';
const int _timeOut = 20000;

class DioHelper {
  final Dio dio;

  DioHelper({required this.dio}) {
    final Map<String, dynamic> headers = {_contentType: _applicationJson};
    dio.options = BaseOptions(
      baseUrl: AppConstants.apiBaseUrl,
      receiveDataWhenStatusError: true,
      receiveTimeout: const Duration(milliseconds: _timeOut),
      connectTimeout: const Duration(milliseconds: _timeOut),
      headers: headers,
    );
    if (kDebugMode) {
      // dio.interceptors.add(sl<LogInterceptor>());
      // dio.interceptors.add(sl<AppInterceptors>());
    }
  }

  Future<Response> get({
    required String url,
    Map<String, dynamic>? queryParams,
  }) async {
    final locale = sl<SettingsCubit>().state.language.resolveLocale(
      ui.PlatformDispatcher.instance.locale,
    );
    final mergedQueryParameters = <String, dynamic>{
      'langId':
          locale.languageCode == 'ar'
              ? AppConstants.apiArabicLangId
              : AppConstants.apiEnglishLangId,
      ...?queryParams,
    };
    return await dio.get(url, queryParameters: mergedQueryParameters);
  }
}
