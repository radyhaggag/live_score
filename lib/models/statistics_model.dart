class StatisticsModel {
  Team? team;
  List<Statistics> statistics = [];
  StatisticsModel.fromJson(Map<String, dynamic> json) {
    team = Team.fromJson(json["team"]);
    json['statistics'].forEach((element) {
      statistics.add(Statistics.fromJson(element));
    });
  }
}

class Team {
  int? id;
  String? name;
  String? logo;
  Team.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
  }
}

class Statistics {
  String? type;
  dynamic value;

  Statistics.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    value = json['value'] ?? 0;
  }
}
