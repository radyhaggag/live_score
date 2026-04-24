import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:live_score/src/features/fixture/domain/entities/fixture_details.dart';

import '../../../domain/use_cases/fixture_details_usecase.dart';

part 'fixture_state.dart';

/// Manages fetching fixture details (lineups, events, players) independently
/// from match statistics.
class FixtureCubit extends Cubit<FixtureState> {
  final FixtureDetailsUseCase fixtureDetailsUseCase;

  FixtureCubit({required this.fixtureDetailsUseCase})
      : super(FixtureInitial());

  bool _isLoading = false;

  /// Fetch fixture details for the given [fixtureId].
  Future<void> getFixtureDetails(
    int fixtureId, {
    bool isTimerLoading = false,
  }) async {
    if (_isLoading) return;

    _isLoading = true;
    try {
      emit(FixtureDetailsLoading(isTimerLoading: isTimerLoading));
      final result = await fixtureDetailsUseCase(fixtureId);
      if (isClosed) return;
      result.fold(
        (left) => emit(FixtureDetailsLoadingFailure(message: left.message)),
        (right) => emit(FixtureDetailsLoaded(fixtureDetails: right)),
      );
    } finally {
      _isLoading = false;
    }
  }
}
