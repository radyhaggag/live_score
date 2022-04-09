class StandingsModel {
  int? rank;
  Team? team;
  int? points;
  int? goalsDiff;
  String? form;
  All? all;
  StandingsModel.fromJson(Map<String, dynamic> json) {
    rank = json['rank'];
    team = Team.fromJson(json['team']);
    points = json['points'];
    goalsDiff = json['goalsDiff'];
    form = json['form'];
    all = All.fromJson(json['all']);
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

class All {
  int? played;
  int? win;
  int? draw;
  int? lose;
  int? goalsFor;
  int? goalsAgainst;
  All.fromJson(Map<String, dynamic> json) {
    played = json['played'];
    win = json['win'];
    draw = json['draw'];
    lose = json['lose'];
    goalsFor = json['goals']["for"];
    goalsAgainst = json['goals']['against'];
  }
}
