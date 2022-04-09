import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_score/layout/cubit/states.dart';
import 'package:live_score/models/fixtures_model.dart';
import 'package:live_score/models/leagues_model.dart';
import 'package:live_score/models/lineups_model.dart';
import 'package:live_score/models/standings_model.dart';
import 'package:live_score/models/statistics_model.dart';
import 'package:live_score/modules/home_screen/home_screen.dart';
import 'package:live_score/modules/matches_screen/matches_screen.dart';
import 'package:live_score/modules/standings_screen/standings_screen.dart';
import 'package:live_score/shared/network/dio_helper.dart';
import 'package:live_score/shared/network/endpoints.dart';

import '../../models/events_model.dart';

class LiveScoreCubit extends Cubit<LiveScoreStates> {
  LiveScoreCubit() : super(LiveScoreInitialState());

  static LiveScoreCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    const HomeScreen(),
    const MatchesScreen(),
    const StandingsScreen(),
  ];

  List<String> titles = [
    "Live Score",
    "Matches",
    "Standings",
  ];

  int currentIndex = 0;
  void changeBottomNav(int index) {
    currentIndex = index;
    emit(LiveScoreChangeBottomNavState());
  }

  List<SoccerMatch> matches = [];
  List<SoccerMatch> egyptionLeagueMatches = [];
  List<SoccerMatch> premierLeagueMatches = [];
  List<SoccerMatch> laLigaMatches = [];
  List<SoccerMatch> ligue1Matches = [];
  List<SoccerMatch> bundesligaMatches = [];
  List<SoccerMatch> serieAMatches = [];
  List<SoccerMatch> uefaChampionsMatches = [];
  List<SoccerMatch> cafChampionshipMatches = [];
  List<SoccerMatch> worldCupMatches = [];
  List<SoccerMatch> liveMatches = [];

  void getFixtures(String date) {
    matches = [];
    egyptionLeagueMatches = [];
    premierLeagueMatches = [];
    laLigaMatches = [];
    ligue1Matches = [];
    bundesligaMatches = [];
    serieAMatches = [];
    uefaChampionsMatches = [];
    cafChampionshipMatches = [];
    worldCupMatches = [];
    liveMatches = [];
    emit(LiveScoreGetFixturesLoadingState());
    DioHelper.getData(endPoint: GET_FIXTURES, query: {
      "date": date,
    }).then((value) {
      List<dynamic> matchesList = value.data['response'];
      for (var match in matchesList) {
        if (match["league"]["id"] == 39) {
          premierLeagueMatches.add(SoccerMatch.fromJson(match));
          matches.add(SoccerMatch.fromJson(match));
          if (match["fixture"]["status"]["elapsed"] != null &&
              match["fixture"]["status"]["elapsed"] < 90) {
            liveMatches.add(SoccerMatch.fromJson(match));
          }
        }
        if (match["league"]["id"] == 140) {
          laLigaMatches.add(SoccerMatch.fromJson(match));
          matches.add(SoccerMatch.fromJson(match));
          if (match["fixture"]["status"]["elapsed"] != null &&
              match["fixture"]["status"]["elapsed"] < 90) {
            liveMatches.add(SoccerMatch.fromJson(match));
          }
        }
        if (match["league"]["id"] == 135) {
          serieAMatches.add(SoccerMatch.fromJson(match));
          matches.add(SoccerMatch.fromJson(match));
          if (match["fixture"]["status"]["elapsed"] != null &&
              match["fixture"]["status"]["elapsed"] < 90) {
            liveMatches.add(SoccerMatch.fromJson(match));
          }
        }
        if (match["league"]["id"] == 61) {
          ligue1Matches.add(SoccerMatch.fromJson(match));
          matches.add(SoccerMatch.fromJson(match));
          if (match["fixture"]["status"]["elapsed"] != null &&
              match["fixture"]["status"]["elapsed"] < 90) {
            liveMatches.add(SoccerMatch.fromJson(match));
          }
        }
        if (match["league"]["id"] == 78) {
          bundesligaMatches.add(SoccerMatch.fromJson(match));
          matches.add(SoccerMatch.fromJson(match));
          if (match["fixture"]["status"]["elapsed"] != null &&
              match["fixture"]["status"]["elapsed"] < 90) {
            liveMatches.add(SoccerMatch.fromJson(match));
          }
        }
        if (match["league"]["id"] == 2) {
          uefaChampionsMatches.add(SoccerMatch.fromJson(match));
          matches.add(SoccerMatch.fromJson(match));
          if (match["fixture"]["status"]["elapsed"] != null &&
              match["fixture"]["status"]["elapsed"] < 90) {
            liveMatches.add(SoccerMatch.fromJson(match));
          }
        }
        if (match["league"]["id"] == 12) {
          cafChampionshipMatches.add(SoccerMatch.fromJson(match));
          matches.add(SoccerMatch.fromJson(match));
          if (match["fixture"]["status"]["elapsed"] != null &&
              match["fixture"]["status"]["elapsed"] < 90) {
            liveMatches.add(SoccerMatch.fromJson(match));
          }
        }
        if (match["league"]["id"] == 1) {
          worldCupMatches.add(SoccerMatch.fromJson(match));
          matches.add(SoccerMatch.fromJson(match));
          if (match["fixture"]["status"]["elapsed"] != null &&
              match["fixture"]["status"]["elapsed"] < 90) {
            liveMatches.add(SoccerMatch.fromJson(match));
          }
        }
        if (match["league"]["id"] == 233) {
          egyptionLeagueMatches.add(SoccerMatch.fromJson(match));
          matches.add(SoccerMatch.fromJson(match));
          if (match["fixture"]["status"]["elapsed"] != null &&
              match["fixture"]["status"]["elapsed"] < 90) {
            liveMatches.add(SoccerMatch.fromJson(match));
          }
        }
      }
      emit(LiveScoreGetFixturesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(LiveScoreGetFixturesErrorState());
    });
  }

  List<LeagueModel> leagues = [];

  void getLeagues() {
    emit(LiveScoreGetLeaguesLoadingState());

    DioHelper.getData(endPoint: GET_LEAGUES, query: {"current": "true"}).then(
      (value) {
        List<dynamic> leaguesList = value.data['response'];
        for (var element in leaguesList) {
          if (element["league"]["id"] == 39 ||
              element["league"]["id"] == 140 ||
              element["league"]["id"] == 135 ||
              element["league"]["id"] == 61 ||
              element["league"]["id"] == 78 ||
              element["league"]["id"] == 2 ||
              element["league"]["id"] == 12 ||
              element["league"]["id"] == 1 ||
              element["league"]["id"] == 233) {
            leagues.add(LeagueModel.fromJson(element));
          }
        }
        emit(LiveScoreGetLeaguesSuccessState());
      },
    ).catchError(
      (error) {
        print(error.toString());
        emit(LiveScoreGetLeaguesErrorState());
      },
    );
  }

  List<StatisticsModel> statistics = [];
  Future<void> getStatistics({@required String? fixtureId}) async {
    statistics = [];
    emit(LiveScoreGetStatisticsLoadingState());

    return await DioHelper.getData(
        endPoint: "$GET_FIXTURES/$GET_Statistics",
        query: {
          "fixture": fixtureId,
        }).then(
      (value) {
        List<dynamic> statisticsList = value.data['response'];
        statistics =
            statisticsList.map((e) => StatisticsModel.fromJson(e)).toList();
        emit(LiveScoreGetStatisticsSuccessState());
      },
    ).catchError(
      (error) {
        print(error.toString());
        emit(LiveScoreGetStatisticsErrorState());
      },
    );
  }

  int statsIndex = 0;
  void changStats(int index) {
    statsIndex = index;
    emit(LiveScoreChangeStatsState());
  }

  List<LineupsModel> lineups = [];

  Future<void> getLineups({@required String? fixtureId}) async {
    emit(LiveScoreGetLineupsLoadingState());
    return await DioHelper.getData(
        endPoint: "$GET_FIXTURES/$GET_LINEUPS",
        query: {
          "fixture": fixtureId,
        }).then(
      (value) {
        List<dynamic> lineupsList = value.data['response'];
        lineups = lineupsList.map((e) => LineupsModel.fromJson(e)).toList();
        emit(LiveScoreGetLineupsSuccessState());
      },
    ).catchError(
      (error) {
        print(error.toString());
        emit(LiveScoreGetLineupsErrorState());
      },
    );
  }

  List<EventsModel> events = [];

  Future<void> getEvents({@required String? fixtureId}) async {
    events = [];
    emit(LiveScoreGetEventsLoadingState());
    return await DioHelper.getData(
        endPoint: "$GET_FIXTURES/$GET_EVENTS",
        query: {
          "fixture": fixtureId,
        }).then(
      (value) {
        List<dynamic> eventsList = value.data['response'];
        events = eventsList.map((e) => EventsModel.fromJson(e)).toList();
        emit(LiveScoreGetEventsSuccessState());
      },
    ).catchError(
      (error) {
        print(error.toString());
        emit(LiveScoreGetEventsErrorState());
      },
    );
  }

  int? leagueId = 0;
  void getLeagueId(int id) {
    leagueId = id;
    emit(LiveScoreGetLeagueIdState());
  }

  List<StandingsModel> standings = [];
  List<dynamic> standingsGroups = [];

  void getStandings({
    @required String? season,
    @required String? leagueId,
  }) {
    standings = [];
    standingsGroups = [];
    emit(LiveScoreGetStandingsLoadingState());

    DioHelper.getData(endPoint: GET_STANDINGS, query: {
      "season": season,
      "league": leagueId,
    }).then(
      (value) {
        List<dynamic> standingsRes =
            value.data['response'][0]["league"]["standings"];

        for (var item in standingsRes) {
          standingsGroups.add(item);
          for (var e in item) {
            standings.add(StandingsModel.fromJson(e));
          }
        }
        emit(LiveScoreGetStandingsSuccessState());
      },
    ).catchError(
      (error) {
        print(error.toString());
        emit(LiveScoreGetStandingsErrorState());
      },
    );
  }
}
