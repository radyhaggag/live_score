import '../../domain/entities/player.dart';

class PlayerModel extends Player {
  const PlayerModel(
      {required super.id,
      required super.name,
      required super.number,
      required super.grid,
      required super.pos});

  factory PlayerModel.fromJson(Map<String, dynamic> json) => PlayerModel(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        number: json["number"] ?? 0,
        pos: json["pos"] ?? "NF",
        grid: json["grid"] ?? "-1",
      );
}
