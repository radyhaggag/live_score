import '../domain/entities/fixture_league.dart';

class FixtureLeagueModel extends FixtureLeague {
  const FixtureLeagueModel({
    required int id,
    required String name,
    required String logo,
    required int season,
    required String round,
  }) : super(id: id, name: name, logo: logo, season: season, round: round);

  factory FixtureLeagueModel.fromJson(Map<String, dynamic> json) =>
      FixtureLeagueModel(
        id: json['id'],
        name: json['name'],
        logo: json['logo'],
        season: json['season'],
        round: json['round'],
      );
}
