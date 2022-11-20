import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/domain/entities/league.dart';
import '../../../../core/domain/entities/soccer_fixture.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_strings.dart';
import '../../domain/entities/league_of_fixture.dart';
import '../../domain/use_cases/day_fixtures_usecase.dart';
import '../../domain/use_cases/leagues_usecase.dart';
import '../../domain/use_cases/live_fixtures_usecase.dart';
import '../../domain/use_cases/standings_usecase.dart';
import '../screens/fixtures_screen.dart';
import '../screens/soccer_screen.dart';
import '../screens/standings_screen.dart';
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

  List screens = [
    const SoccerScreen(),
    const FixturesScreen(),
    const StandingsScreen(),
  ];

  List<String> titles = [
    AppStrings.liveScore,
    AppStrings.fixtures,
    AppStrings.standings,
  ];

  int currentIndex = 0;

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(SoccerChangeBottomNav());
  }

  List<League> filteredLeagues = [];

  Future<List<League>> getLeagues() async {
    emit(SoccerLeaguesLoading());
    filteredLeagues = [];
    final leagues = await leaguesUseCase(NoParams());
    leagues.fold(
      (left) => emit(SoccerLeaguesLoadFailure(left.message)),
      (right) {
        for (League league in right) {
          if (AppConstants.availableLeagues.contains(league.id)) {
            filteredLeagues.add(league);
            AppConstants.leaguesFixtures
                .putIfAbsent(league.id, () => LeagueOfFixture(league: league));
          }
        }
        emit(SoccerLeaguesLoaded(filteredLeagues));
      },
    );
    return filteredLeagues;
  }

  List<SoccerFixture> dayFixtures = [];

  Future<List<SoccerFixture>> getFixtures() async {
    emit(SoccerFixturesLoading());
    String date = DateFormat("yyyy-MM-dd").format(DateTime.now());
    final fixtures = await dayFixturesUseCase(date);
    List<SoccerFixture> filteredFixtures = [];
    fixtures.fold(
      (left) => emit(SoccerFixturesLoadFailure(left.message)),
      (right) {
        AppConstants.leaguesFixtures.forEach((key, value) {
          value.fixtures.clear();
        });
        for (SoccerFixture fixture in right) {
          if (AppConstants.availableLeagues
              .contains(fixture.fixtureLeague.id)) {
            filteredFixtures.add(fixture);
            AppConstants.leaguesFixtures[fixture.fixtureLeague.id]!.fixtures
                .add(fixture);
          }
          dayFixtures = filteredFixtures;
        }
        emit(SoccerFixturesLoaded(filteredFixtures));
      },
    );
    return filteredFixtures;
  }

  Future<List<SoccerFixture>> getLiveFixtures() async {
    emit(SoccerFixturesLoading());
    final liveFixtures = await liveFixturesUseCase(NoParams());
    List<SoccerFixture> filteredFixtures = [];
    liveFixtures.fold(
      (left) => emit(SoccerLiveFixturesLoadFailure(left.message)),
      (right) {
        filteredFixtures = right
            .where((fixture) => AppConstants.availableLeagues
                .contains(fixture.fixtureLeague.id))
            .toList();
        emit(SoccerLiveFixturesLoaded(filteredFixtures));
      },
    );
    return filteredFixtures;
  }

  List<SoccerFixture> currentFixtures = [];

  loadCurrentFixtures(int leagueId) {
    currentFixtures = AppConstants.leaguesFixtures[leagueId]?.fixtures ?? [];
    emit(SoccerCurrentFixturesChanges());
  }

  Future<void> getStandings(StandingsParams params) async {
    emit(SoccerStandingsLoading());
    final standings = await standingUseCase(params);
    standings.fold(
      (left) => emit(SoccerStandingsLoadFailure(left.message)),
      (right) {
        emit(SoccerStandingsLoaded(right));
      },
    );
  }
}
