import '../../data/models/standings_model.dart';
import '../../data/models/team_rank_model.dart';
import '../entities/standings.dart';
import '../entities/team_rank.dart';

extension TeamRankExtension on TeamRankModel {
  TeamRank toDomain() => TeamRank(
        rank: rank,
        team: team,
        points: points,
        goalsDiff: goalsDiff,
        lastMatches: lastMatches,
        stats: stats,
        group: group,
      );
}

extension TeamRankStatsExtension on TeamRankStatsModel {
  TeamRankStats toDomain() => TeamRankStats(
        played: played,
        win: win,
        draw: draw,
        lose: lose,
        scored: scored,
        received: received,
      );
}

extension StandingsExtension on StandingsModel {
  Standings toDomain() => Standings(standings: standings);
}
