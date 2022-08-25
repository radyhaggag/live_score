part of 'fixture_cubit.dart';

@immutable
abstract class FixtureState {}

class FixtureInitial extends FixtureState {}

class FixtureChangeBar extends FixtureState {}

class FixtureStatisticsLoading extends FixtureState {}

class FixtureStatisticsLoaded extends FixtureState {
  final List<Statistics> statistics;

  FixtureStatisticsLoaded({required this.statistics});
}

class FixtureStatisticsLoadingFailure extends FixtureState {
  final String message;

  FixtureStatisticsLoadingFailure({required this.message});
}

class FixtureLineupsLoading extends FixtureState {}

class FixtureLineupsLoaded extends FixtureState {
  final List<Lineup> lineups;

  FixtureLineupsLoaded({required this.lineups});
}

class FixtureLineupsLoadingFailure extends FixtureState {
  final String message;

  FixtureLineupsLoadingFailure({required this.message});
}

class FixtureEventsLoading extends FixtureState {}

class FixtureEventsLoaded extends FixtureState {
  final List<Event> events;

  FixtureEventsLoaded({required this.events});
}

class FixtureEventsLoadingFailure extends FixtureState {
  final String message;

  FixtureEventsLoadingFailure({required this.message});
}
