import '../domain/entities/league.dart';

class LeagueModel extends League {
  const LeagueModel({
    required super.id,
    required super.name,
    required super.type,
    required super.logo,
    required super.year,
  });

  factory LeagueModel.fromJson(Map<String, dynamic> json) => LeagueModel(
        id: json["league"]['id'],
        name: json["league"]['name'],
        type: json["league"]['type'],
        logo: json["league"]['logo'],
        year: List.from(json["seasons"]).last["year"],
      );
}
