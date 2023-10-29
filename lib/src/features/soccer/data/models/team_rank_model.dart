import '../../../../core/domain/mappers/mappers.dart';
import '../../../../core/models/teams_model.dart';
import '../../domain/entities/team_rank.dart';
import '../../domain/mappers/mappers.dart';

class TeamRankModel extends TeamRank {
  const TeamRankModel({
    required super.rank,
    required super.team,
    required super.points,
    required super.goalsDiff,
    required super.lastMatches,
    required super.stats,
    required super.group,
  });

  factory TeamRankModel.fromJson(Map<String, dynamic> json) => TeamRankModel(
        rank: json["rank"],
        team: TeamModel.fromJson(json["team"]).toDomain(),
        points: json["points"],
        goalsDiff: json["goalsDiff"],
        lastMatches: json["form"],
        group: json["group"],
        stats: TeamRankStatsModel.fromJson(json["all"]).toDomain(),
      );
}

class TeamRankStatsModel extends TeamRankStats {
  const TeamRankStatsModel({
    required super.played,
    required super.win,
    required super.draw,
    required super.lose,
    required super.scored,
    required super.received,
  });

  factory TeamRankStatsModel.fromJson(Map<String, dynamic> json) =>
      TeamRankStatsModel(
        played: json["played"],
        win: json["win"],
        draw: json["draw"],
        lose: json["lose"],
        scored: json["goals"]["for"],
        received: json["goals"]["against"],
      );
}
