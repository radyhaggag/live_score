import '../domain/entities/goals.dart';

/// Represents the goals model entity/model.
class GoalsModel extends Goals {
  const GoalsModel({required super.home, required super.away});

  factory GoalsModel.fromJson(Map<String, dynamic> json) =>
      GoalsModel(home: json['home'], away: json['away']);
}
