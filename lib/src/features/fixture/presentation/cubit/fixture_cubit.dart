import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import '../../domain/use_cases/events_usecase.dart';
import '../../domain/use_cases/lineups_usecase.dart';
import '../../domain/entities/events.dart';
import '../../domain/entities/lineups.dart';
import '../../domain/entities/statistics.dart';
import '../../domain/use_cases/statistics_usecase.dart';

part 'fixture_state.dart';

class FixtureCubit extends Cubit<FixtureState> {
  final StatisticsUseCase statisticsUseCase;
  final LineupsUseCase lineupsUseCase;
  final EventsUseCase eventsUseCase;

  FixtureCubit({
    required this.statisticsUseCase,
    required this.lineupsUseCase,
    required this.eventsUseCase,
  }) : super(FixtureInitial());

  List<Statistics> statistics = [];

  Future<void> getStatistics(String fixtureId) async {
    if (statistics.isEmpty) {
      emit(FixtureStatisticsLoading());
      final result = await statisticsUseCase(fixtureId);
      result.fold(
        (left) {
          emit(FixtureStatisticsLoadingFailure(message: left.message));
        },
        (right) {
          statistics = right;
          emit(FixtureStatisticsLoaded(statistics: right));
        },
      );
    } else {
      emit(FixtureStatisticsLoaded(statistics: statistics));
    }
  }

  List<Lineup> lineups = [];

  Future<void> getLineups(String fixtureId) async {
    if (lineups.isEmpty) {
      emit(FixtureLineupsLoading());
      final result = await lineupsUseCase(fixtureId);
      result.fold(
        (left) => emit(FixtureLineupsLoadingFailure(message: left.message)),
        (right) {
          lineups = right;
          emit(FixtureLineupsLoaded(lineups: right));
        },
      );
    } else {
      emit(FixtureLineupsLoaded(lineups: lineups));
    }
  }

  List<Event> events = [];

  Future<void> getEvents(String fixtureId) async {
    if (events.isEmpty) {
      emit(FixtureEventsLoading());
      final result = await eventsUseCase(fixtureId);
      result.fold(
        (left) {
          emit(FixtureEventsLoadingFailure(message: left.message));
        },
        (right) {
          events = right;
          emit(FixtureEventsLoaded(events: right));
        },
      );
    } else {
      emit(FixtureEventsLoaded(events: events));
    }
  }
}
