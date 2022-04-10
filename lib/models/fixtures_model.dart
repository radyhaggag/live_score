class SoccerFixtures {
  Fixture? fixture;
  League? league;
  Team? home;
  Team? away;
  Goals? goals;
  SoccerFixtures.fromJson(Map<String, dynamic> json) {
    fixture = Fixture.fromJson(json['fixture']);
    league = League.fromJson(json['league']);
    home = Team.fromJson(json['teams']['home']);
    away = Team.fromJson(json['teams']['away']);
    goals = Goals.fromJson(json['goals']);
  }
}

class Fixture {
  int? id;
  String? timezone;
  String? date;
  Status? status;

  Fixture.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    timezone = json['timezone'];
    date = json['date'];
    status = Status.fromJson(json['status']);
  }
}

class Status {
  String? long;
  String? short;
  int? elapsed;
  Status.fromJson(Map<String, dynamic> json) {
    long = json['long'];
    short = json['short'];
    elapsed = json['elapsed'];
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

class Team {
  int? id;
  String? name;
  String? logo;
  bool? winner;
  Team.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    winner = json['winner'];
  }
}

class Goals {
  int? home;
  int? away;
  Goals.fromJson(Map<String, dynamic> json) {
    home = json['home'];
    away = json['away'];
  }
}
