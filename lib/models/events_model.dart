class EventsModel {
  Time? time;
  Team? team;
  Player? player;
  Player? assist;
  String? type;
  String? detail;
  EventsModel.fromJson(Map<String, dynamic> json) {
    time = Time.fromJson(json['time']);
    team = Team.fromJson(json['team']);
    player = Player.fromJson(json['player']);
    assist = Player.fromJson(json['assist']);
    type = json['type'];
    detail = json['detail'];
  }
}

class Time {
  int? elapsed;
  int? extra;
  Time.fromJson(Map<String, dynamic> json) {
    elapsed = json['elapsed'];
    extra = json['extra'] ?? 0;
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

class Player {
  dynamic id;
  dynamic name;
  Player.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
