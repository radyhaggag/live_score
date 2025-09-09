import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/entities/league.dart';
import '../../../../core/domain/entities/soccer_fixture.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/app_constants.dart';
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
    emit(SoccerFixturesLoading());
    final fixtures = await currentRoundFixturesUseCase(competitionId);
    fixtures.fold(
      (left) => emit(SoccerFixturesLoadFailure(left.message)),
      (right) => emit(SoccerCurrentRoundFixturesLoaded(right)),
    );
  }

  List<SoccerFixture> liveFixtures = [];

  Future<List<SoccerFixture>> getTodayFixtures() async {
    emit(SoccerFixturesLoading());
    final todayFixtures = await todayFixturesUseCase(NoParams());
    List<SoccerFixture> filteredFixtures = [];
    todayFixtures.fold(
      (left) => emit(SoccerTodayFixturesLoadFailure(left.message)),
      (right) {
        filteredFixtures =
            right
                .where(
                  (fixture) => AppConstants.availableLeagues.contains(
                    fixture.fixtureLeague.id,
                  ),
                )
                .toList();
        emit(SoccerTodayFixturesLoaded(filteredFixtures));
      },
    );
    return filteredFixtures;
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
