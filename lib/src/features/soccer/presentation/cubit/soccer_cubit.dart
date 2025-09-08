import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/domain/entities/league.dart';
import '../../../../core/domain/entities/soccer_fixture.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/app_constants.dart';
import '../../domain/entities/league_of_fixture.dart';
import '../../domain/use_cases/day_fixtures_usecase.dart';
import '../../domain/use_cases/leagues_usecase.dart';
import '../../domain/use_cases/live_fixtures_usecase.dart';
import '../../domain/use_cases/standings_usecase.dart';
import 'soccer_state.dart';

class SoccerCubit extends Cubit<SoccerStates> {
  final DayFixturesUseCase dayFixturesUseCase;
  final LeaguesUseCase leaguesUseCase;
  final LiveFixturesUseCase liveFixturesUseCase;
  final StandingsUseCase standingUseCase;

  SoccerCubit({
    required this.dayFixturesUseCase,
    required this.leaguesUseCase,
    required this.liveFixturesUseCase,
    required this.standingUseCase,
  }) : super(ScoreInitial());

  List<League> filteredLeagues = [];
  Map<int, LeagueOfFixture> leaguesFixtures = {};

  Future<List<League>> getLeagues() async {
    if (filteredLeagues.isNotEmpty) return filteredLeagues;

    emit(SoccerLeaguesLoading());
    final leagues = await leaguesUseCase(NoParams());
    leagues.fold((left) => emit(SoccerLeaguesLoadFailure(left.message)), (
      right,
    ) {
      filteredLeagues = right;
      for (League league in right) {
        leaguesFixtures.putIfAbsent(
          league.id,
          () => LeagueOfFixture(league: league),
        );
      }
      emit(SoccerLeaguesLoaded(filteredLeagues));
    });
    return filteredLeagues;
  }

  List<SoccerFixture> dayFixtures = [];

  Future<List<SoccerFixture>> getFixtures() async {
    emit(SoccerFixturesLoading());
    String date = DateFormat("yyyy-MM-dd").format(DateTime.now());
    final fixtures = await dayFixturesUseCase(date);
    List<SoccerFixture> filteredFixtures = [];
    fixtures.fold((left) => emit(SoccerFixturesLoadFailure(left.message)), (
      right,
    ) {
      leaguesFixtures.forEach((key, value) {
        value.fixtures.clear();
      });
      for (SoccerFixture fixture in right) {
        if (AppConstants.availableLeagues.contains(fixture.fixtureLeague.id)) {
          filteredFixtures.add(fixture);
          leaguesFixtures[fixture.fixtureLeague.id]!.fixtures.add(fixture);
        }
        dayFixtures = filteredFixtures;
      }
      emit(SoccerFixturesLoaded(filteredFixtures));
    });
    return filteredFixtures;
  }

  List<SoccerFixture> liveFixtures = [];

  Future<List<SoccerFixture>> getLiveFixtures() async {
    emit(SoccerFixturesLoading());
    final liveFixtures = await liveFixturesUseCase(NoParams());
    List<SoccerFixture> filteredFixtures = [];
    liveFixtures.fold(
      (left) => emit(SoccerLiveFixturesLoadFailure(left.message)),
      (right) {
        filteredFixtures =
            right
                .where(
                  (fixture) => AppConstants.availableLeagues.contains(
                    fixture.fixtureLeague.id,
                  ),
                )
                .toList();
        emit(SoccerLiveFixturesLoaded(filteredFixtures));
      },
    );
    return filteredFixtures;
  }

  List<SoccerFixture> currentFixtures = [];

  void loadCurrentFixtures(int leagueId) {
    currentFixtures = leaguesFixtures[leagueId]?.fixtures ?? [];
    emit(SoccerCurrentFixturesChanges());
  }

  Future<void> getStandings(StandingsParams params) async {
    if (state is SoccerStandingsLoading) return;
    emit(SoccerStandingsLoading());
    final standings = await standingUseCase(params);
    standings.fold(
      (left) => emit(SoccerStandingsLoadFailure(left.message)),
      (right) => emit(SoccerStandingsLoaded(right)),
    );
  }
}
