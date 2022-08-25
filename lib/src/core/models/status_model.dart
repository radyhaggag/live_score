import '../domain/entities/status.dart';

class StatusModel extends Status {
  const StatusModel({
    required String long,
    required String short,
    required int? elapsed,
  }) : super(long: long, short: short, elapsed: elapsed);

  factory StatusModel.fromJson(Map<String, dynamic> json) => StatusModel(
        long: json['long'],
        short: json['short'],
        elapsed: json['elapsed'],
      );
}
