part of 'fixture_cubit.dart';

@immutable
abstract class FixtureState {}

class FixtureInitial extends FixtureState {}

class FixtureChangeBar extends FixtureState {}

class FixtureStatisticsLoading extends FixtureState {}

class FixtureStatisticsLoaded extends FixtureState {
  final Statistics statistics;

  FixtureStatisticsLoaded({required this.statistics});
}

class FixtureStatisticsLoadingFailure extends FixtureState {
  final String message;

  FixtureStatisticsLoadingFailure({required this.message});
}

class FixtureDetailsLoading extends FixtureState {}

class FixtureDetailsLoaded extends FixtureState {
  final FixtureDetails fixtureDetails;

  FixtureDetailsLoaded({required this.fixtureDetails});
}

class FixtureDetailsLoadingFailure extends FixtureState {
  final String message;

  FixtureDetailsLoadingFailure({required this.message});
}
