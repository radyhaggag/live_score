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

  Future<List<SoccerFixtureModel>> getCurrentRoundFixtures({
    required int competitionId,
  });

  Future<List<SoccerFixtureModel>> getTodayFixtures();

  Future<StandingsModel> getStandings({required StandingsParams params});
}

class SoccerDataSourceImpl implements SoccerDataSource {
  final DioHelper dioHelper;

  SoccerDataSourceImpl({required this.dioHelper});

  @override
  Future<List<SoccerFixtureModel>> getCurrentRoundFixtures({
    required int competitionId,
  }) async {
    try {
      final response = await dioHelper.get(
        url: Endpoints.currentRoundFixtures,
        queryParams: {"competitions": competitionId},
      );
      return _getResult(response);
    } catch (error) {
      rethrow;
    }
  }

  List<LeagueModel> _cacheLeagues = [];

  @override
  Future<List<LeagueModel>> getLeagues() async {
    try {
      final response = await dioHelper.get(
        url: Endpoints.leagues,
        queryParams: {
          'competitions': AppConstants.availableLeagues.join(','),
        },
      );
      List<dynamic> result = response.data["competitions"];
      final countries = List<CountryModel>.from(
        response.data["countries"].map((item) => CountryModel.fromJson(item)),
      );
      _cacheLeagues = List<LeagueModel>.from(
        result.map(
          (item) => LeagueModel.fromJson(
            item,
            country: countries.firstWhere(
              (country) => country.id == item["countryId"],
            ),
          ),
        ),
      );
      return _cacheLeagues;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<List<SoccerFixtureModel>> getTodayFixtures() async {
    try {
      final response = await dioHelper.get(
        url: Endpoints.todayFixtures,
        queryParams: {
          'sports': 1,
          'startDate': DateTime.now().toIso8601String().split('T').first,
          'endDate': DateTime.now().toIso8601String().split('T').first,
        },
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

  List<SoccerFixtureModel> _getResult(Response response) {
    List<dynamic> result = response.data["games"];
    final List<int> competitionIds =
        response.data['competitions']
            .map<int>((competition) => competition['id'] as int)
            .toSet()
            .toList();
    final availableId = competitionIds.lastWhere(
      (id) => AppConstants.availableLeagues.contains(id),
      orElse: () => -1,
    );

    // if availableId is -1, it means not in the available leagues, skip this fixture

    // List<SoccerFixtureModel> fixtures = List<SoccerFixtureModel>.from(
    //   result.map((fixture) {
    //     final model = SoccerFixtureModel.fromJson(
    //       fixture,
    //       fixtureLeague: _cacheLeagues.firstWhere(
    //         (league) => league.id == availableId,
    //       ),
    //     );
    //     return model;
    //   }),
    // );

    List<SoccerFixtureModel> fixtures = [];
    for (var fixture in result) {
      if (availableId == -1) continue;
      final model = SoccerFixtureModel.fromJson(
        fixture,
        fixtureLeague: _cacheLeagues.firstWhere(
          (league) => league.id == availableId,
        ),
      );
      fixtures.add(model);
    }
    return fixtures;
  }
}
