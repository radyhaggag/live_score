import 'package:live_score/src/core/domain/mappers/mappers.dart';
import 'package:live_score/src/core/utils/parsers.dart';

import '../../../../core/models/teams_model.dart';
import '../../domain/entities/statistics.dart';

class StatisticsModel extends Statistics {
  const StatisticsModel({required super.teams, required super.statistics});

  factory StatisticsModel.fromJson(Map<String, dynamic> json) {
    if (json['games'] == null || (json['games'] as List).isEmpty) {
      return const StatisticsModel(teams: null, statistics: null);
    }
    final firstMatch = (json['games'] as List).first;
    return StatisticsModel(
      teams: TeamsModel.fromJson(firstMatch).toDomain(),
      statistics: List<Statistic>.from(
        json['statistics'].map(
          (statistic) => StatisticModel.fromJson(statistic),
        ),
      ),
    );
  }
}

class StatisticModel extends Statistic {
  const StatisticModel({
    required super.id,
    required super.competitorId,
    required super.name,
    required super.value,
    required super.valuePercentage,
    required super.order,
    super.categoryId,
    super.categoryName,
    super.isTop = false,
  });

  factory StatisticModel.fromJson(Map<String, dynamic> json) => StatisticModel(
    id: json['id'],
    competitorId: json['competitorId'],
    name: json['name'],
    value: json['value']?.toString() ?? '0',
    valuePercentage: json['valuePercentage']?.toDouble() ?? 0.0,
    order: toInt(json['order']) ?? 0,
    categoryId: toInt(json['categoryId']),
    categoryName: json['categoryName'] as String?,
    isTop: json['isTop'] == true,
  );
}
