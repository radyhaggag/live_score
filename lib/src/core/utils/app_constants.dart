import '../../features/soccer/domain/entities/league_of_fixture.dart';

class AppConstants {
  AppConstants._();
  static const String baseUrl = "https://v3.football.api-sports.io/";
  static const int timeOutDuration = 90;
  static const int maxNameLength = 3;

  static const List<int> availableLeagues = [
    1,
    2,
    3,
    4,
    5,
    6,
    12,
    15,
    20,
    39,
    61,
    78,
    135,
    140,
    233,
  ];

  static Map<int, LeagueOfFixture> leaguesFixtures = {};
}
