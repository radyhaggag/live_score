import 'package:dio/dio.dart';
import '../models/standings_model.dart';
import '../../domain/use_cases/standings_usecase.dart';
import '../../../../core/api/dio_helper.dart';
import '../../../../core/models/league_model.dart';
import '../../../../core/models/soccer_fixture_model.dart';
import '../../../../core/api/endpoints.dart';

abstract class SoccerDataSource {
  Future<List<LeagueModel>> getLeagues();

  Future<List<SoccerFixtureModel>> getDayFixtures({
    required String date,
  });

  Future<List<SoccerFixtureModel>> getLiveFixtures();

  Future<StandingsModel> getStandings({required StandingsParams params});
}

class SoccerDataSourceImpl implements SoccerDataSource {
  final DioHelper dioHelper;

  SoccerDataSourceImpl({required this.dioHelper});

  @override
  Future<List<SoccerFixtureModel>> getDayFixtures(
      {required String date}) async {
    try {
      final response = await dioHelper
          .get(url: Endpoints.fixtures, queryParams: {"date": date});
      return _getResult(response);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<List<LeagueModel>> getLeagues() async {
    try {
      final response = await dioHelper.get(url: Endpoints.leagues);
      List<dynamic> result = response.data["response"];
      List<LeagueModel> leagues = List<LeagueModel>.from(result.map(
        (item) => LeagueModel.fromJson(item),
      ));
      return leagues;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<List<SoccerFixtureModel>> getLiveFixtures() async {
    try {
      final response = await dioHelper
          .get(url: Endpoints.fixtures, queryParams: {"live": "all"});
      return _getResult(response);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<StandingsModel> getStandings({required StandingsParams params}) async {
    try {
      final response = await dioHelper.get(
          url: Endpoints.standings, queryParams: params.toJson());
      List<dynamic> result = response.data["response"];
      StandingsModel standings = result.isNotEmpty
          ? StandingsModel.fromJson(result.first["league"])
          : const StandingsModel(standings: []);
      return standings;
    } catch (error) {
      rethrow;
    }
  }
}

List<SoccerFixtureModel> _getResult(Response response) {
  List<dynamic> result = response.data["response"];
  List<SoccerFixtureModel> fixtures = List<SoccerFixtureModel>.from(result.map(
    (fixture) => SoccerFixtureModel.fromJson(fixture),
  ));
  return fixtures;
}
