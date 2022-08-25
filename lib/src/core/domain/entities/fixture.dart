import 'package:equatable/equatable.dart';

import 'status.dart';

class Fixture extends Equatable {
  final int id;
  final String date;
  final String referee;
  final Status status;

  const Fixture({
    required this.id,
    required this.date,
    required this.referee,
    required this.status,
  });

  @override
  List<Object?> get props => [id, date, referee, status];
}
