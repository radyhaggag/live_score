import 'package:live_score/src/features/fixture/data/models/fixture_details_model.dart';

import '../../../../core/api/dio_helper.dart';
import '../../../../core/api/endpoints.dart';
import '../models/statistics_model.dart';

abstract class FixtureDataSource {
  Future<StatisticsModel> getStatistics(int fixtureId);

  Future<FixtureDetailsModel> getFixtureDetails(int fixtureId);
}

class FixtureDataSourceImpl implements FixtureDataSource {
  final DioHelper dioHelper;

  FixtureDataSourceImpl({required this.dioHelper});

  @override
  Future<FixtureDetailsModel> getFixtureDetails(int fixtureId) async {
    try {
      final response = await dioHelper.get(
        url: Endpoints.fixtureDetails,
        queryParams: {'gameId': fixtureId},
      );
      final result = response.data['game'];
      return FixtureDetailsModel.fromJson(result);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<StatisticsModel> getStatistics(int fixtureId) async {
    try {
      final response = await dioHelper.get(
        url: Endpoints.matchStatistics,
        queryParams: {'games': fixtureId},
      );
      final result = response.data;
      return StatisticsModel.fromJson(result);
    } catch (error) {
      rethrow;
    }
  }
}
