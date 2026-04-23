import '../../container_injector.dart';
import 'data/repositories/settings_repository_impl.dart';
import 'domain/repositories/settings_repository.dart';
import 'presentation/cubit/settings_cubit.dart';

void initSettings() {
  sl.registerLazySingleton<SettingsRepository>(() => SettingsRepositoryImpl());
  sl.registerLazySingleton<SettingsCubit>(
    () => SettingsCubit(settingsRepository: sl<SettingsRepository>()),
  );
}
