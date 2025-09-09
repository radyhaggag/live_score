import 'package:dio/dio.dart';
import 'package:live_score/src/core/models/country_model.dart';
import 'package:live_score/src/core/utils/app_constants.dart';

import '../../../../core/api/dio_helper.dart';
import '../../../../core/api/endpoints.dart';
import '../../../../core/domain/entities/soccer_fixture.dart';
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
      final leagues = List<LeagueModel>.from(
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

  List<SoccerFixtureModel> _getResult(
    Response response, {
    bool removeOldFixturesByOneDay = true,
  }) {
    List<dynamic> result = response.data["games"];

    List<SoccerFixtureModel> fixtures = [];
    for (var fixture in result) {
      final competitionId = fixture['competitionId'] as int?;
      if (competitionId == null ||
          !AppConstants.availableLeagues.contains(competitionId)) {
        continue;
      }
      final model = SoccerFixtureModel.fromJson(
        fixture,
        fixtureLeague: FixtureLeague(
          id: competitionId,
          name: fixture['competitionDisplayName'],
        ),
      );
      if (removeOldFixturesByOneDay && model.startTime != null) {
        final now = DateTime(
          DateTime.now().toUtc().year,
          DateTime.now().toUtc().month,
          DateTime.now().toUtc().day,
        );
        final fixtureDate = DateTime(
          model.startTime!.toUtc().year,
          model.startTime!.toUtc().month,
          model.startTime!.toUtc().day,
        );
        if (fixtureDate.isBefore(now)) continue;
      }
      fixtures.add(model);
    }
    return fixtures;
  }
}
