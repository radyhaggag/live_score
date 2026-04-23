import '../../container_injector.dart';
import '../../core/api/dio_helper.dart';
import '../../core/network/network_info.dart';
import 'data/datasources/soccer_data_source.dart';
import 'data/repositories/soccer_repository_impl.dart';
import 'domain/repositories/soccer_repository.dart';
import 'domain/use_cases/day_fixtures_usecase.dart';
import 'domain/use_cases/leagues_usecase.dart';
import 'domain/use_cases/live_fixtures_usecase.dart';
import 'domain/use_cases/standings_usecase.dart';
import 'presentation/cubit/leagues_cubit.dart';
import 'presentation/cubit/soccer_cubit.dart';

void initSoccer() {
  sl.registerLazySingleton<SoccerDataSource>(
    () => SoccerDataSourceImpl(dioHelper: sl<DioHelper>()),
  );
  sl.registerLazySingleton<SoccerRepository>(
    () => SoccerRepositoryImpl(
      networkInfo: sl<NetworkInfo>(),
      soccerDataSource: sl<SoccerDataSource>(),
    ),
  );
  sl.registerLazySingleton<CurrentRoundFixturesUseCase>(
    () => CurrentRoundFixturesUseCase(soccerRepository: sl<SoccerRepository>()),
  );
  sl.registerLazySingleton<LeaguesUseCase>(
    () => LeaguesUseCase(soccerRepository: sl<SoccerRepository>()),
  );

  sl.registerLazySingleton<TodayFixturesUseCase>(
    () => TodayFixturesUseCase(soccerRepository: sl<SoccerRepository>()),
  );
  sl.registerLazySingleton<StandingsUseCase>(
    () => StandingsUseCase(soccerRepository: sl<SoccerRepository>()),
  );
  sl.registerFactory<SoccerCubit>(
    () => SoccerCubit(
      currentRoundFixturesUseCase: sl<CurrentRoundFixturesUseCase>(),
      todayFixturesUseCase: sl<TodayFixturesUseCase>(),
      standingUseCase: sl<StandingsUseCase>(),
    ),
  );
  sl.registerFactory<LeaguesCubit>(
    () => LeaguesCubit(leaguesUseCase: sl<LeaguesUseCase>()),
  );
}
