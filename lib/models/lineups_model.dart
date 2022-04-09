class LineupsModel {
  Team? team;
  String? formation;
  List<Player> startXI = [];
  List<Player> substitutes = [];
  Coach? coach;
  LineupsModel.fromJson(Map<String, dynamic> json) {
    team = Team.fromJson(json['team']);
    formation = json['formation'];
    json['startXI'].forEach((element) {
      startXI.add(Player.fromJson(element['player']));
    });
    json['substitutes'].forEach((element) {
      substitutes.add(Player.fromJson(element['player']));
    });
    coach = Coach.fromJson(json['coach']);
  }
}

class Team {
  int? id;
  String? name;
  String? logo;
  PlayerColors? playerColors;
  Team.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    playerColors = PlayerColors.fromJson(json['colors']['player']);
  }
}

class PlayerColors {
  String? primary;
  String? number;
  String? border;
  PlayerColors.fromJson(Map<String, dynamic> json) {
    primary = json['primary'];
    number = json['number'];
    border = json['border'];
  }
}

class Coach {
  int? id;
  String? name;
  Coach.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}

class Player {
  int? id;
  String? name;
  int? number;
  String? pos;
  dynamic grid;
  Player.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    number = json["number"];
    pos = json["pos"];
    grid = json["grid"];
  }
}
