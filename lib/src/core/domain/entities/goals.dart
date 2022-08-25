import 'package:equatable/equatable.dart';

class Goals extends Equatable {
  final int? home;
  final int? away;

  const Goals({required this.home, required this.away});

  @override
  List<Object?> get props => [home, away];
}
