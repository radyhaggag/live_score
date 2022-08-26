import '../../domain/entities/player.dart';

class PlayerModel extends Player {
  const PlayerModel(
      {required int id,
      required String name,
      required int number,
      required String grid,
      required String pos})
      : super(id: id, name: name, number: number, grid: grid, pos: pos);

  factory PlayerModel.fromJson(Map<String, dynamic> json) => PlayerModel(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        number: json["number"] ?? 0,
        pos: json["pos"] ?? "NF",
        grid: json["grid"] ?? "-1",
      );
}
