import '../domain/entities/fixture.dart';
import '../domain/entities/status.dart';
import '../domain/mappers/mappers.dart';

import 'status_model.dart';

class FixtureModel extends Fixture {
  const FixtureModel({
    required int id,
    required String date,
    required String referee,
    required Status status,
  }) : super(id: id, date: date, referee: referee, status: status);

  factory FixtureModel.fromJson(Map<String, dynamic> json) => FixtureModel(
        id: json['id'],
        date: json['date'],
        referee: json['referee'] ?? "",
        status: StatusModel.fromJson(json['status']).toDomain(),
      );
}
