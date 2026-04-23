import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/app_language.dart';
import '../../data/repositories/settings_repository_impl.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit({required this.settingsRepository})
    : super(const SettingsState());

  final SettingsRepositoryImpl settingsRepository;

  Future<void> loadSettings() async {
    final ThemeMode themeMode = await settingsRepository.getThemeMode();
    final AppLanguage language = await settingsRepository.getAppLanguage();
    final String appVersion = await settingsRepository.getAppVersion();

    emit(
      state.copyWith(
        themeMode: themeMode,
        appVersion: appVersion,
        language: language,
      ),
    );
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    await settingsRepository.setThemeMode(themeMode);
    emit(state.copyWith(themeMode: themeMode));
  }

  Future<void> setLanguage(AppLanguage language) async {
    await settingsRepository.setAppLanguage(language);
    emit(state.copyWith(language: language));
  }
}
