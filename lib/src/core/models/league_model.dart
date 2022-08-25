import '../domain/entities/league.dart';

class LeagueModel extends League {
  const LeagueModel({
    required int id,
    required String name,
    required String type,
    required String logo,
    required int year,
  }) : super(id: id, name: name, type: type, logo: logo, year: year);

  factory LeagueModel.fromJson(Map<String, dynamic> json) => LeagueModel(
        id: json["league"]['id'],
        name: json["league"]['name'],
        type: json["league"]['type'],
        logo: json["league"]['logo'],
        year: List.from(json["seasons"]).last["year"],
      );
}
