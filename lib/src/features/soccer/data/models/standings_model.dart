import 'team_rank_model.dart';
import '../../domain/entities/team_rank.dart';
import '../../domain/mappers/mappers.dart';
import '../../domain/entities/standings.dart';

class StandingsModel extends Standings {
  const StandingsModel({required super.standings});

  factory StandingsModel.fromJson(Map<dynamic, dynamic> json) => StandingsModel(
        standings: List<List<TeamRank>>.from(
          json["standings"].map((item) {
            List<TeamRank> groups = [];
            item.forEach((team) {
              groups.add(TeamRankModel.fromJson(team).toDomain());
            });
            return groups;
          }).toList(),
        ),
      );
}
