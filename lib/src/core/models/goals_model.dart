import '../domain/entities/goals.dart';

class GoalsModel extends Goals {
  const GoalsModel({
    required int? home,
    required int? away,
  }) : super(home: home, away: away);

  factory GoalsModel.fromJson(Map<String, dynamic> json) => GoalsModel(
        home: json['home'],
        away: json['away'],
      );
}
