import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  AppConstants._();
  static const int timeOutDuration = 90;
  static const int maxNameLength = 3;

  static const List<int> availableLeagues = [
    7,
    11,
    17,
    25,
    35,
    552,
    572,
    73,
    57,
  ];

  static String clubImage(String clubId, {String size = '24'}) {
    return '${dotenv.env['BASE_IMAGE_URL']!}f_png,w_$size,h_$size,c_limit,q_auto:eco,dpr_3,d_Competitors:default1.png/v7/Competitors/$clubId';
  }

  static String competitionImage(String competitionId, {String size = '24'}) {
    return '${dotenv.env['BASE_IMAGE_URL']!}f_png,w_$size,h_$size,c_limit,q_auto:eco,dpr_3,d_Countries:default1.png/v7/Competitions/$competitionId';
  }

  static final String baseUrl = dotenv.env['API_BASE_URL'] ?? '';
}
