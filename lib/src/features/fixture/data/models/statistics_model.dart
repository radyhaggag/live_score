import '../../../../core/domain/mappers/mappers.dart';
import '../../../../core/models/teams_model.dart';
import '../../domain/mappers/mappers.dart';
import '../../domain/entities/statistics.dart';

class StatisticsModel extends Statistics {
  const StatisticsModel({required super.team, required super.statistics});

  factory StatisticsModel.fromJson(Map<String, dynamic> json) =>
      StatisticsModel(
        team: TeamModel.fromJson(json["team"]).toDomain(),
        statistics: List<Statistic>.from(
          json["statistics"].map(
            (statistic) => StatisticModel.fromJson(statistic).toDomain(),
          ),
        ),
      );
}

class StatisticModel extends Statistic {
  const StatisticModel({required super.type, required super.value});

  factory StatisticModel.fromJson(Map<String, dynamic> json) => StatisticModel(
      type: json["type"], value: json["value"]?.toString() ?? "0");
}
