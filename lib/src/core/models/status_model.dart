import '../domain/entities/status.dart';

/// Represents the status model entity/model.
class StatusModel extends Status {
  const StatusModel({
    required super.long,
    required super.short,
    required super.elapsed,
  });

  factory StatusModel.fromJson(Map<String, dynamic> json) => StatusModel(
    long: json['long'],
    short: json['short'],
    elapsed: json['elapsed'],
  );
}
