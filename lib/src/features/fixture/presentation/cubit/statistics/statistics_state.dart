part of 'statistics_cubit.dart';

@immutable
sealed class StatisticsState {}

/// Represents the statistics initial state.
class StatisticsInitial extends StatisticsState {}

/// Represents the statistics loading state.
class StatisticsLoading extends StatisticsState {
  final bool isTimerLoading;

  StatisticsLoading({this.isTimerLoading = false});
}

/// Represents the statistics loaded state.
class StatisticsLoaded extends StatisticsState {
  final Statistics statistics;

  StatisticsLoaded({required this.statistics});
}

/// Represents the statistics loading failure state.
class StatisticsLoadingFailure extends StatisticsState {
  final String message;

  StatisticsLoadingFailure({required this.message});
}
