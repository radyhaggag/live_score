import 'package:dio/dio.dart';
import 'package:live_score/src/core/models/country_model.dart';
import 'package:live_score/src/core/constants/app_constants.dart';

import '../../../../core/api/dio_helper.dart';
import '../../../../core/api/endpoints.dart';
import '../../../../core/domain/entities/league.dart';
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
        queryParams: {'competitions': competitionId},
      );
      return _getResult(response, getOnlyCurrentDayFixtures: false);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<List<LeagueModel>> getLeagues() async {
    try {
      final response = await dioHelper.get(
        url: Endpoints.leagues,
        queryParams: {
          'competitions': AppConstants.availableLeagues.join(','),
          'withBestOdds': true,
        },
      );
      final List<dynamic> result = response.data['competitions'];
      final countries = List<CountryModel>.from(
        response.data['countries'].map((item) => CountryModel.fromJson(item)),
      );
      final leagues = List<LeagueModel>.from(
        result.map(
          (item) => LeagueModel.fromJson(
            item,
            country: countries.firstWhere(
              (country) => country.id == item['countryId'],
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
      final now = DateTime.now();
      final today = now.toIso8601String().split('T').first;
      final response = await dioHelper.get(
        url: Endpoints.todayFixtures,
        queryParams: {'sports': 1, 'startDate': today, 'endDate': today},
      );

      return _getResult(response, getOnlyCurrentDayFixtures: true);
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
      final List<dynamic> result = response.data['standings'];
      final StandingsModel standings =
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
    bool getOnlyCurrentDayFixtures = true,
  }) {
    final List<dynamic> result = response.data['games'];

    final List<SoccerFixtureModel> fixtures = [];
    final today = DateTime.now();
    final normalizedToday = DateTime(today.year, today.month, today.day);
    for (var fixture in result) {
      final competitionId = fixture['competitionId'] as int?;
      if (competitionId == null ||
          !AppConstants.availableLeagues.contains(competitionId)) {
        continue;
      }
      final model = SoccerFixtureModel.fromJson(
        fixture,
        fixtureLeague: League.light(
          id: competitionId,
          name: fixture['competitionDisplayName'],
        ),
      );
      if (getOnlyCurrentDayFixtures && model.startTime != null) {
        final localStartTime = model.startTime!.toLocal();
        final fixtureDate = DateTime(
          localStartTime.year,
          localStartTime.month,
          localStartTime.day,
        );

        if (fixtureDate.isAfter(normalizedToday)) continue;
      }
      fixtures.add(model);
    }
    return fixtures;
  }
}
