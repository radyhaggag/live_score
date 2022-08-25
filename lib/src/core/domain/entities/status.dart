import 'package:equatable/equatable.dart';

class Status extends Equatable {
  final String long;
  final String short;
  final int? elapsed;

  const Status(
      {required this.long, required this.short, required this.elapsed});

  @override
  List<Object?> get props => [long, short, elapsed];
}
