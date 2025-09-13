class AppConstants {
  AppConstants._();

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
    649, // Saudi Pro League
  ];

  static const apiBaseUrl = 'https://webws.365scores.com/web';
  static const baseImageUrl = 'https://imagecache.365scores.com/image/upload/';

  static String clubImage(String clubId, {String size = '24'}) {
    return '${baseImageUrl}f_png,w_$size,h_$size,c_limit,q_auto:eco,dpr_3,d_Competitors:default1.png/v7/Competitors/$clubId';
  }

  static String competitionImage(int competitionId, {String size = '24'}) {
    return '${baseImageUrl}f_png,w_$size,h_$size,c_limit,q_auto:eco,dpr_3,d_Countries:default1.png/v7/Competitions/$competitionId';
  }
}
