part of 'fixture_cubit.dart';

@immutable
sealed class FixtureState {}

/// Represents the fixture initial entity/model.
class FixtureInitial extends FixtureState {}

/// Represents the fixture statistics loading entity/model.
class FixtureStatisticsLoading extends FixtureState {
  final bool isTimerLoading;

  FixtureStatisticsLoading({this.isTimerLoading = false});
}

/// Represents the fixture statistics loaded entity/model.
class FixtureStatisticsLoaded extends FixtureState {
  final Statistics statistics;

  FixtureStatisticsLoaded({required this.statistics});
}

/// Represents the fixture statistics loading failure entity/model.
class FixtureStatisticsLoadingFailure extends FixtureState {
  final String message;

  FixtureStatisticsLoadingFailure({required this.message});
}

/// Represents the fixture details loading entity/model.
class FixtureDetailsLoading extends FixtureState {
  final bool isTimerLoading;

  FixtureDetailsLoading({this.isTimerLoading = false});
}

/// Represents the fixture details loaded entity/model.
class FixtureDetailsLoaded extends FixtureState {
  final FixtureDetails fixtureDetails;

  FixtureDetailsLoaded({required this.fixtureDetails});
}

/// Represents the fixture details loading failure entity/model.
class FixtureDetailsLoadingFailure extends FixtureState {
  final String message;

  FixtureDetailsLoadingFailure({required this.message});
}
