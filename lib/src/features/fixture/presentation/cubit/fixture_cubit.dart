import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:live_score/src/features/fixture/domain/entities/fixture_details.dart';

import '../../domain/entities/statistics.dart';
import '../../domain/use_cases/fixture_details_usecase.dart';
import '../../domain/use_cases/statistics_usecase.dart';

part 'fixture_state.dart';

class FixtureCubit extends Cubit<FixtureState> {
  final StatisticsUseCase statisticsUseCase;
  final FixtureDetailsUseCase fixtureDetailsUseCase;

  FixtureCubit({
    required this.statisticsUseCase,
    required this.fixtureDetailsUseCase,
  }) : super(FixtureInitial());

  Statistics? statistics;

  Future<void> getStatistics(int fixtureId) async {
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
  }

  FixtureDetails? fixtureDetails;

  Future<void> getFixtureDetails(int fixtureId) async {
    if (fixtureDetails == null) {
      emit(FixtureDetailsLoading());
      final result = await fixtureDetailsUseCase(fixtureId);
      result.fold(
        (left) {
          emit(FixtureDetailsLoadingFailure(message: left.message));
        },
        (right) {
          fixtureDetails = right;
          emit(FixtureDetailsLoaded(fixtureDetails: right));
        },
      );
    } else {
      emit(FixtureDetailsLoaded(fixtureDetails: fixtureDetails!));
    }
  }
}
