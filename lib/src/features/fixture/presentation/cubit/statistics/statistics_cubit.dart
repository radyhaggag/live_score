import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

import '../../../domain/entities/statistics.dart';
import '../../../domain/use_cases/statistics_usecase.dart';

part 'statistics_state.dart';

/// Manages fetching match statistics independently from fixture details.
class StatisticsCubit extends Cubit<StatisticsState> {
  final StatisticsUseCase statisticsUseCase;

  StatisticsCubit({required this.statisticsUseCase})
      : super(StatisticsInitial());

  bool _isLoading = false;

  /// Fetch match statistics for the given [fixtureId].
  Future<void> getStatistics(
    int fixtureId, {
    bool isTimerLoading = false,
  }) async {
    if (_isLoading) return;

    _isLoading = true;
    try {
      emit(StatisticsLoading(isTimerLoading: isTimerLoading));
      final result = await statisticsUseCase(fixtureId);
      if (isClosed) return;
      result.fold(
        (left) => emit(StatisticsLoadingFailure(message: left.message)),
        (right) => emit(StatisticsLoaded(statistics: right)),
      );
    } finally {
      _isLoading = false;
    }
  }
}
