import 'package:equatable/equatable.dart';

/// Represents the goals entity/model.
class Goals extends Equatable {
  final int? home;
  final int? away;

  const Goals({required this.home, required this.away});

  @override
  List<Object?> get props => [home, away];
}
