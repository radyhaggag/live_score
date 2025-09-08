import 'package:live_score/src/features/soccer/domain/mappers/mappers.dart';

import '../../domain/entities/standings.dart';
import '../../domain/entities/team_rank.dart';
import 'team_rank_model.dart';

class StandingsModel extends Standings {
  const StandingsModel({required super.standings});

  factory StandingsModel.fromJson(Map<dynamic, dynamic> json) => StandingsModel(
    standings: List<TeamRank>.from(
      json["rows"].map((item) {
        return TeamRankModel.fromJson(item).toDomain();
      }).toList(),
    ),
  );
}
