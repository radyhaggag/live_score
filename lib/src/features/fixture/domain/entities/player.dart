import 'package:equatable/equatable.dart';

class Player extends Equatable {
  final int id;
  final int competitorId;
  final String name;
  final String shortName;
  final String nameForURL;
  final int number;

  const Player({
    required this.id,
    required this.competitorId,
    required this.name,
    required this.number,
    required this.shortName,
    required this.nameForURL,
  });

  @override
  List<Object?> get props => [id, name, number, shortName, nameForURL];
}
