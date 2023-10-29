import '../domain/entities/fixture_league.dart';

class FixtureLeagueModel extends FixtureLeague {
  const FixtureLeagueModel({
    required super.id,
    required super.name,
    required super.logo,
    required super.season,
    required super.round,
  });

  factory FixtureLeagueModel.fromJson(Map<String, dynamic> json) =>
      FixtureLeagueModel(
        id: json['id'],
        name: json['name'],
        logo: json['logo'],
        season: json['season'],
        round: json['round'],
      );
}
