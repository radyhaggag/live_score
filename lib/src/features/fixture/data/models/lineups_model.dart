import '../../domain/entities/lineup_team.dart';
import '../../domain/entities/lineups.dart';
import '../../domain/entities/player.dart';
import '../../domain/mappers/mappers.dart';
import 'lineup_team_model.dart';
import 'player_model.dart';

class LineupModel extends Lineup {
  const LineupModel(
      {required LineupTeam team,
      required String coachName,
      required String formation,
      required List<Player> startXI,
      required List<Player> substitutes})
      : super(
          team: team,
          coachName: coachName,
          formation: formation,
          startXI: startXI,
          substitutes: substitutes,
        );

  factory LineupModel.fromJson(Map<String, dynamic> json) => LineupModel(
        team: LineupTeamModel.fromJson(json["team"]),
        coachName: json["coach"]["name"],
        formation: json["formation"],
        startXI: List<Player>.from(
          json["startXI"].map(
              (player) => PlayerModel.fromJson(player["player"]).toDomain()),
        ),
        substitutes: List<Player>.from(
          json["substitutes"].map(
              (player) => PlayerModel.fromJson(player["player"]).toDomain()),
        ),
      );
}
