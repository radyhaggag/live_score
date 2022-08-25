import '../../../../core/domain/entities/teams.dart';
import '../../../../core/domain/mappers/mappers.dart';
import '../../../../core/models/teams_model.dart';
import '../../domain/mappers/mappers.dart';
import '../../domain/entities/statistics.dart';

class StatisticsModel extends Statistics {
  const StatisticsModel(
      {required Team team, required List<Statistic> statistics})
      : super(team: team, statistics: statistics);

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
  const StatisticModel({required String type, required String value})
      : super(type: type, value: value);

  factory StatisticModel.fromJson(Map<String, dynamic> json) =>
      StatisticModel(type: json["type"], value: json["value"]?.toString() ?? "0");
}
