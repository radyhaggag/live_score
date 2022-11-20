import '../../../../core/domain/entities/teams.dart';
import '../../../../core/domain/mappers/mappers.dart';
import '../../../../core/models/teams_model.dart';
import '../../domain/entities/team_rank.dart';
import '../../domain/mappers/mappers.dart';

class TeamRankModel extends TeamRank {
  const TeamRankModel({
    required int rank,
    required Team team,
    required int points,
    required int goalsDiff,
    required String? lastMatches,
    required TeamRankStats stats,
    required String? group,
  }) : super(
          rank: rank,
          team: team,
          points: points,
          goalsDiff: goalsDiff,
          lastMatches: lastMatches,
          stats: stats,
          group: group,
        );

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
    required int played,
    required int win,
    required int draw,
    required int lose,
    required int scored,
    required int received,
  }) : super(
          played: played,
          win: win,
          draw: draw,
          lose: lose,
          scored: scored,
          received: received,
        );

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
