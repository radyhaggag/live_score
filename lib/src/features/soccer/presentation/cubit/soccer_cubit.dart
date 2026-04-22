import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/entities/league.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/use_cases/day_fixtures_usecase.dart';
import '../../domain/use_cases/leagues_usecase.dart';
import '../../domain/use_cases/live_fixtures_usecase.dart';
import '../../domain/use_cases/standings_usecase.dart';
import 'soccer_state.dart';

class SoccerCubit extends Cubit<SoccerStates> {
  final CurrentRoundFixturesUseCase currentRoundFixturesUseCase;
  final LeaguesUseCase leaguesUseCase;
  final TodayFixturesUseCase todayFixturesUseCase;
  final StandingsUseCase standingUseCase;

  SoccerCubit({
    required this.currentRoundFixturesUseCase,
    required this.leaguesUseCase,
    required this.todayFixturesUseCase,
    required this.standingUseCase,
  }) : super(ScoreInitial());

  List<League> availableLeagues = [];
  bool _isLoadingLeagues = false;
  bool _isLoadingTodayFixtures = false;
  bool _isLoadingCurrentRoundFixtures = false;
  bool _isLoadingStandings = false;

  Future<List<League>> getLeagues() async {
    if (availableLeagues.isNotEmpty || _isLoadingLeagues) {
      return availableLeagues;
    }

    _isLoadingLeagues = true;
    try {
      emit(SoccerLeaguesLoading());
      final leagues = await leaguesUseCase(NoParams());
      leagues.fold((left) => emit(SoccerLeaguesLoadFailure(left.message)), (
        right,
      ) {
        availableLeagues = right;
        emit(SoccerLeaguesLoaded(availableLeagues));
      });
    } finally {
      _isLoadingLeagues = false;
    }
    return availableLeagues;
  }

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
