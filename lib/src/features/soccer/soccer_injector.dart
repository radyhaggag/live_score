import '../../container_injector.dart';
import '../../core/api/dio_helper.dart';
import '../../core/network/network_info.dart';
import 'data/datasources/soccer_data_source.dart';
import 'data/repositories/soccer_repository_impl.dart';
import 'domain/use_cases/day_fixtures_usecase.dart';
import 'domain/use_cases/leagues_usecase.dart';
import 'domain/use_cases/live_fixtures_usecase.dart';
import 'domain/use_cases/standings_usecase.dart';
import 'presentation/cubit/soccer_cubit.dart';

void initSoccer() {
  sl.registerLazySingleton<SoccerDataSourceImpl>(
    () => SoccerDataSourceImpl(dioHelper: sl<DioHelper>()),
  );
  sl.registerLazySingleton<SoccerRepositoryImpl>(
    () => SoccerRepositoryImpl(
      networkInfo: sl<NetworkInfoImpl>(),
      soccerDataSource: sl<SoccerDataSourceImpl>(),
    ),
  );
  sl.registerLazySingleton<DayFixturesUseCase>(
    () => DayFixturesUseCase(
      soccerRepository: sl<SoccerRepositoryImpl>(),
    ),
  );
  sl.registerLazySingleton<LeaguesUseCase>(
    () => LeaguesUseCase(
      soccerRepository: sl<SoccerRepositoryImpl>(),
    ),
  );

  sl.registerLazySingleton<LiveFixturesUseCase>(
    () => LiveFixturesUseCase(
      soccerRepository: sl<SoccerRepositoryImpl>(),
    ),
  );
  sl.registerLazySingleton<StandingsUseCase>(
    () => StandingsUseCase(
      soccerRepository: sl<SoccerRepositoryImpl>(),
    ),
  );
  sl.registerFactory<SoccerCubit>(
    () => SoccerCubit(
      dayFixturesUseCase: sl<DayFixturesUseCase>(),
      leaguesUseCase: sl<LeaguesUseCase>(),
      liveFixturesUseCase: sl<LiveFixturesUseCase>(),
      standingUseCase: sl<StandingsUseCase>(),
    ),
  );
}
