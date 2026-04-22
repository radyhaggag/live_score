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
  bool _isLoadingStatistics = false;
  bool _isLoadingFixtureDetails = false;

  Future<void> getStatistics(
    int fixtureId, {
    bool isTimerLoading = false,
  }) async {
    if (_isLoadingStatistics) return;

    _isLoadingStatistics = true;
    try {
      emit(FixtureStatisticsLoading(isTimerLoading: isTimerLoading));
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
    } finally {
      _isLoadingStatistics = false;
    }
  }

  FixtureDetails? fixtureDetails;

  Future<void> getFixtureDetails(
    int fixtureId, {
    bool isTimerLoading = false,
  }) async {
    if (_isLoadingFixtureDetails) return;

    _isLoadingFixtureDetails = true;
    try {
      emit(FixtureDetailsLoading(isTimerLoading: isTimerLoading));
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
    } finally {
      _isLoadingFixtureDetails = false;
    }
  }
}
