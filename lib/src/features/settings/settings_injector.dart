import '../../container_injector.dart';
import 'data/repositories/settings_repository_impl.dart';
import 'presentation/cubit/settings_cubit.dart';

void initSettings() {
  sl.registerLazySingleton<SettingsRepositoryImpl>(
    () => SettingsRepositoryImpl(),
  );
  sl.registerLazySingleton<SettingsCubit>(
    () => SettingsCubit(settingsRepository: sl<SettingsRepositoryImpl>()),
  );
}
