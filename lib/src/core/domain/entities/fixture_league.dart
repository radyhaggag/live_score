import 'package:equatable/equatable.dart';

class FixtureLeague extends Equatable {
  final int id;
  final String name;
  final String logo;
  final int season;
  final String round;

  const FixtureLeague({
    required this.id,
    required this.name,
    required this.logo,
    required this.season,
    required this.round,
  });

  @override
  List<Object?> get props => [id, name, logo, season, round];
}
