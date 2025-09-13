import '../../../../core/utils/parsers.dart';
import '../../domain/entities/player.dart';

class PlayerModel extends Player {
  const PlayerModel({
    required super.id,
    required super.competitorId,
    required super.name,
    required super.shortName,
    required super.nameForURL,
    required super.number,
  });

  factory PlayerModel.fromJson(Map<String, dynamic> json) => PlayerModel(
    id: toInt(json['id']) ?? 0,
    competitorId: toInt(json['competitorId']) ?? 0,
    name: json['name'] ?? '',
    shortName: json['shortName'] ?? '',
    nameForURL: json['nameForURL'] ?? '',
    number: toInt(json['jerseyNumber']) ?? 0,
  );
}
