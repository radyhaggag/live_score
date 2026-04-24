part of 'fixture_cubit.dart';

@immutable
sealed class FixtureState {}

/// Represents the fixture initial state.
class FixtureInitial extends FixtureState {}

/// Represents the fixture details loading state.
class FixtureDetailsLoading extends FixtureState {
  final bool isTimerLoading;

  FixtureDetailsLoading({this.isTimerLoading = false});
}

/// Represents the fixture details loaded state.
class FixtureDetailsLoaded extends FixtureState {
  final FixtureDetails fixtureDetails;

  FixtureDetailsLoaded({required this.fixtureDetails});
}

/// Represents the fixture details loading failure state.
class FixtureDetailsLoadingFailure extends FixtureState {
  final String message;

  FixtureDetailsLoadingFailure({required this.message});
}
