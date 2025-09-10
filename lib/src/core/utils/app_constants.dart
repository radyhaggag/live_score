import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  AppConstants._();
  static const int timeOutDuration = 90;
  static const int maxNameLength = 3;

  static const defaultLeagueId = 7; // English Premier League

  static const List<int> availableLeagues = [
    7, // English Premier League
    11, // La Liga
    17, // Serie A
    25, // Bundesliga
    35, // Ligue 1
    552, // Egyptian Premier League
    572, // UEFA Champions League
    // 332, // it same as 572 champions league but its the qualifiers (not have standings!!!)
    573, // UEFA Europa League
    73, // Liga Portugal
    57, // Eredivisie
  ];

  static String clubImage(String clubId, {String size = '24'}) {
    return '${dotenv.env['BASE_IMAGE_URL']!}f_png,w_$size,h_$size,c_limit,q_auto:eco,dpr_3,d_Competitors:default1.png/v7/Competitors/$clubId';
  }

  static String competitionImage(int competitionId, {String size = '24'}) {
    return '${dotenv.env['BASE_IMAGE_URL']!}f_png,w_$size,h_$size,c_limit,q_auto:eco,dpr_3,d_Countries:default1.png/v7/Competitions/$competitionId';
  }

  static final String baseUrl = dotenv.env['API_BASE_URL'] ?? '';
}
