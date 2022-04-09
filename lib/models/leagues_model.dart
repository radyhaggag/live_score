class LeagueModel {
  int? id;
  String? name;
  String? logo;
  String? type;
  int? currentYear;

  LeagueModel.fromJson(Map<String, dynamic> json) {
    id = json['league']['id'];
    name = json['league']['name'];
    logo = json['league']['logo'];
    type = json['league']['type'];
    currentYear = json['seasons'][0]['year'];
  }
}

class League {
  int? id;
  String? name;
  String? logo;
  String? round;

  League.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    round = json['round'] ?? "";
  }
}
