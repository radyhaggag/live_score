import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/usecase/usecase.dart';
import '../../../domain/use_cases/day_fixtures_usecase.dart';
import '../../../domain/use_cases/live_fixtures_usecase.dart';
import '../../../domain/use_cases/standings_usecase.dart';
import 'soccer_state.dart';

/// Represents the soccer cubit entity/model.
class SoccerCubit extends Cubit<SoccerState> {
  final CurrentRoundFixturesUseCase currentRoundFixturesUseCase;
  final TodayFixturesUseCase todayFixturesUseCase;
  final StandingsUseCase standingUseCase;

  SoccerCubit({
    required this.currentRoundFixturesUseCase,
    required this.todayFixturesUseCase,
    required this.standingUseCase,
  }) : super(SoccerInitial());

  bool _isLoadingTodayFixtures = false;
  bool _isLoadingCurrentRoundFixtures = false;
  bool _isLoadingStandings = false;

  /// Get current round fixtures.
  Future<void> getCurrentRoundFixtures({required int competitionId}) async {
    if (_isLoadingCurrentRoundFixtures) return;

    _isLoadingCurrentRoundFixtures = true;
    try {
      emit(SoccerCurrentRoundFixturesLoading());
      final fixtures = await currentRoundFixturesUseCase(competitionId);
      fixtures.fold(
        (left) => emit(
          SoccerCurrentRoundFixturesLoadFailure(
            left.message,
            competitionId: competitionId,
          ),
        ),
        (right) => emit(SoccerCurrentRoundFixturesLoaded(right)),
      );
    } finally {
      _isLoadingCurrentRoundFixtures = false;
    }
  }

  Future<void> getTodayFixtures({bool isTimerLoading = false}) async {
    if (_isLoadingTodayFixtures) return;

    _isLoadingTodayFixtures = true;
    try {
      emit(SoccerTodayFixturesLoading(isTimerLoading: isTimerLoading));
      final todayFixtures = await todayFixturesUseCase(NoParams());
      todayFixtures.fold(
        (left) => emit(SoccerTodayFixturesLoadFailure(left.message)),
        (right) {
          final liveFixtures = right.where((fixture) => fixture.status.isLive);
          emit(
            SoccerTodayFixturesLoaded(
              todayFixtures: right,
              liveFixtures: liveFixtures.toList(),
            ),
          );
        },
      );
    } finally {
      _isLoadingTodayFixtures = false;
    }
  }

  /// Get standings.
  Future<void> getStandings(StandingsParams params) async {
    if (_isLoadingStandings) return;

    _isLoadingStandings = true;
    try {
      emit(SoccerStandingsLoading());
      final standings = await standingUseCase(params);
      standings.fold(
        (left) => emit(SoccerStandingsLoadFailure(left.message)),
        (right) => emit(SoccerStandingsLoaded(right)),
      );
    } finally {
      _isLoadingStandings = false;
    }
  }
}
