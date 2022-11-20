import '../../domain/entities/lineup_team.dart';
import '../../domain/mappers/mappers.dart';

class LineupTeamModel extends LineupTeam {
  const LineupTeamModel(
      {required int id,
      required String name,
      required String logo,
      required LineupColors colors})
      : super(id: id, name: name, logo: logo, colors: colors);

  factory LineupTeamModel.fromJson(Map<String, dynamic> json) =>
      LineupTeamModel(
        id: json["id"],
        name: json["name"],
        logo: json["logo"],
        colors: LineupColorsModel.fromJson(json["colors"]).toDomain(),
      );
}

class PlayerColorsModel extends PlayerColors {
  const PlayerColorsModel(
      {required String primary, required String number, required String border})
      : super(primary: primary, number: number, border: border);

  factory PlayerColorsModel.fromJson(Map<String, dynamic> json) =>
      PlayerColorsModel(
        primary: json["primary"] ?? "808080",
        number: json["number"] ?? "000000",
        border: json["border"] ?? "FFFFFF",
      );
}

class LineupColorsModel extends LineupColors {
  const LineupColorsModel(
      {required PlayerColors player, required PlayerColors goalKeeper})
      : super(player: player, goalKeeper: goalKeeper);

  factory LineupColorsModel.fromJson(Map<String, dynamic> json) =>
      LineupColorsModel(
        player: PlayerColorsModel.fromJson(json["player"]),
        goalKeeper: PlayerColorsModel.fromJson(json["goalkeeper"]),
      );
}
