import '../../domain/entities/lineup_team.dart';
import '../../domain/mappers/mappers.dart';

class LineupTeamModel extends LineupTeam {
  const LineupTeamModel(
      {required super.id,
      required super.name,
      required super.logo,
      required super.colors});

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
      {required super.primary, required super.number, required super.border});

  factory PlayerColorsModel.fromJson(Map<String, dynamic> json) =>
      PlayerColorsModel(
        primary: json["primary"] ?? "808080",
        number: json["number"] ?? "000000",
        border: json["border"] ?? "FFFFFF",
      );
}

class LineupColorsModel extends LineupColors {
  const LineupColorsModel({required super.player, required super.goalKeeper});

  factory LineupColorsModel.fromJson(Map<String, dynamic> json) =>
      LineupColorsModel(
        player: PlayerColorsModel.fromJson(json["player"]),
        goalKeeper: PlayerColorsModel.fromJson(json["goalkeeper"]),
      );
}
