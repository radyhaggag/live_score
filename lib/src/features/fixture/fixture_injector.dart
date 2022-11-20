import '../../container_injector.dart';
import '../../core/api/dio_helper.dart';
import '../../core/network/network_info.dart';
import 'data/data_sources/fixture_data_source.dart';
import 'data/repositories/fixture_repository_impl.dart';
import 'domain/use_cases/events_usecase.dart';
import 'domain/use_cases/lineups_usecase.dart';
import 'domain/use_cases/statistics_usecase.dart';
import 'presentation/cubit/fixture_cubit.dart';

void initFixture() {
  sl.registerLazySingleton<FixtureDataSourceImpl>(
    () => FixtureDataSourceImpl(dioHelper: sl<DioHelper>()),
  );
  sl.registerLazySingleton(
    () => FixtureRepositoryImpl(
      networkInfo: sl<NetworkInfoImpl>(),
      fixtureDataSource: sl<FixtureDataSourceImpl>(),
    ),
  );
  sl.registerLazySingleton(
    () => StatisticsUseCase(fixtureRepository: sl<FixtureRepositoryImpl>()),
  );
  sl.registerLazySingleton(
    () => LineupsUseCase(fixtureRepository: sl<FixtureRepositoryImpl>()),
  );
  sl.registerLazySingleton(
    () => EventsUseCase(fixtureRepository: sl<FixtureRepositoryImpl>()),
  );
  sl.registerFactory(
    () => FixtureCubit(
      eventsUseCase: sl<EventsUseCase>(),
      lineupsUseCase: sl<LineupsUseCase>(),
      statisticsUseCase: sl<StatisticsUseCase>(),
    ),
  );
}
