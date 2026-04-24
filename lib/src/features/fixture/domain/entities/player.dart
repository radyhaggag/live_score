import 'package:equatable/equatable.dart';

/// Represents the player entity/model.
class Player extends Equatable {
  final int id;
  final int competitorId;
  final String name;
  final String shortName;
  final String nameForURL;
  final int number;
  final int? imageId;

  const Player({
    required this.id,
    required this.competitorId,
    required this.name,
    required this.number,
    required this.shortName,
    required this.nameForURL,
    this.imageId,
  });

  String get displayName => shortName.isNotEmpty ? shortName : name;

  @override
  List<Object?> get props => [id, name, number, shortName, nameForURL, imageId];
}
