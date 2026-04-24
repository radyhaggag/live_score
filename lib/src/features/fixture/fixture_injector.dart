import '../../container_injector.dart';
import '../../core/api/dio_helper.dart';
import '../../core/network/network_info.dart';
import 'data/data_sources/fixture_data_source.dart';
import 'data/repositories/fixture_repository_impl.dart';
import 'domain/repositories/fixture_repository.dart';
import 'domain/use_cases/fixture_details_usecase.dart';
import 'domain/use_cases/statistics_usecase.dart';
import 'presentation/cubit/fixture/fixture_cubit.dart';
import 'presentation/cubit/statistics/statistics_cubit.dart';

void initFixture() {
  sl.registerLazySingleton<FixtureDataSource>(
    () => FixtureDataSourceImpl(dioHelper: sl<DioHelper>()),
  );
  sl.registerLazySingleton<FixtureRepository>(
    () => FixtureRepositoryImpl(
      networkInfo: sl<NetworkInfo>(),
      fixtureDataSource: sl<FixtureDataSource>(),
    ),
  );
  sl.registerLazySingleton(
    () => StatisticsUseCase(fixtureRepository: sl<FixtureRepository>()),
  );
  sl.registerLazySingleton(
    () => FixtureDetailsUseCase(fixtureRepository: sl<FixtureRepository>()),
  );
  sl.registerFactory(
    () => FixtureCubit(fixtureDetailsUseCase: sl<FixtureDetailsUseCase>()),
  );
  sl.registerFactory(
    () => StatisticsCubit(statisticsUseCase: sl<StatisticsUseCase>()),
  );
}
