import 'package:dio/dio.dart';
import 'package:live_score/src/core/models/country_model.dart';
import 'package:live_score/src/core/utils/app_constants.dart';

import '../../../../core/api/dio_helper.dart';
import '../../../../core/api/endpoints.dart';
import '../../../../core/models/league_model.dart';
import '../../../../core/models/soccer_fixture_model.dart';
import '../../domain/use_cases/standings_usecase.dart';
import '../models/standings_model.dart';

abstract class SoccerDataSource {
  Future<List<LeagueModel>> getLeagues();

  Future<List<SoccerFixtureModel>> getDayFixtures({required String date});

  Future<List<SoccerFixtureModel>> getLiveFixtures();

  Future<StandingsModel> getStandings({required StandingsParams params});
}

class SoccerDataSourceImpl implements SoccerDataSource {
  final DioHelper dioHelper;

  SoccerDataSourceImpl({required this.dioHelper});

  @override
  Future<List<SoccerFixtureModel>> getDayFixtures({
    required String date,
  }) async {
    try {
      final response = await dioHelper.get(
        url: Endpoints.fixtures,
        queryParams: {"date": date},
      );
      return _getResult(response);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<List<LeagueModel>> getLeagues() async {
    try {
      final response = await dioHelper.get(
        url: Endpoints.leagues,
        queryParams: {'competitions': AppConstants.availableLeagues.join(',')},
      );
      List<dynamic> result = response.data["competitions"];
      final countries = List<CountryModel>.from(
        response.data["countries"].map((item) => CountryModel.fromJson(item)),
      );
      List<LeagueModel> leagues = List<LeagueModel>.from(
        result.map(
          (item) => LeagueModel.fromJson(
            item,
            country: countries.firstWhere(
              (country) => country.id == item["countryId"],
            ),
          ),
        ),
      );
      return leagues;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<List<SoccerFixtureModel>> getLiveFixtures() async {
    try {
      final response = await dioHelper.get(
        url: Endpoints.fixtures,
        queryParams: {"live": "all"},
      );
      return _getResult(response);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<StandingsModel> getStandings({required StandingsParams params}) async {
    try {
      final response = await dioHelper.get(
        url: Endpoints.standings,
        queryParams: params.toJson(),
      );
      List<dynamic> result = response.data["standings"];
      StandingsModel standings =
          result.isNotEmpty
              ? StandingsModel.fromJson(result.first)
              : const StandingsModel(standings: []);
      return standings;
    } catch (error) {
      rethrow;
    }
  }
}

List<SoccerFixtureModel> _getResult(Response response) {
  List<dynamic> result = response.data["response"];
  List<SoccerFixtureModel> fixtures = List<SoccerFixtureModel>.from(
    result.map((fixture) => SoccerFixtureModel.fromJson(fixture)),
  );
  return fixtures;
}
