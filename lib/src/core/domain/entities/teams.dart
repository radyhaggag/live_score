import 'package:equatable/equatable.dart';

class Teams extends Equatable {
  final Team home;
  final Team away;

  const Teams({required this.home, required this.away});

  @override
  List<Object?> get props => [home, away];
}

class Team extends Equatable {
  final int id;
  final String name;
  final String logo;
  final bool? winner;

  const Team({
    required this.id,
    required this.name,
    required this.logo,
    this.winner,
  });

  @override
  List<Object?> get props => [id, name, logo, winner];
}
