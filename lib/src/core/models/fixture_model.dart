import '../domain/entities/fixture.dart';
import '../domain/mappers/mappers.dart';

import 'status_model.dart';

class FixtureModel extends Fixture {
  const FixtureModel({
    required super.id,
    required super.date,
    required super.referee,
    required super.status,
  });

  factory FixtureModel.fromJson(Map<String, dynamic> json) => FixtureModel(
        id: json['id'],
        date: json['date'],
        referee: json['referee'] ?? "",
        status: StatusModel.fromJson(json['status']).toDomain(),
      );
}
