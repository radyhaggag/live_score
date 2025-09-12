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

  Future<List<League>> getLeagues() async {
    if (availableLeagues.isNotEmpty) return availableLeagues;

    emit(SoccerLeaguesLoading());
    final leagues = await leaguesUseCase(NoParams());
    leagues.fold((left) => emit(SoccerLeaguesLoadFailure(left.message)), (
      right,
    ) {
      availableLeagues = right;
      emit(SoccerLeaguesLoaded(availableLeagues));
    });
    return availableLeagues;
  }

  Future<void> getCurrentRoundFixtures({required int competitionId}) async {
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
  }

  Future<void> getTodayFixtures({bool isTimerLoading = false}) async {
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
  }

  Future<void> getStandings(StandingsParams params) async {
    emit(SoccerStandingsLoading());
    final standings = await standingUseCase(params);
    standings.fold(
      (left) => emit(SoccerStandingsLoadFailure(left.message)),
      (right) => emit(SoccerStandingsLoaded(right)),
    );
  }
}
