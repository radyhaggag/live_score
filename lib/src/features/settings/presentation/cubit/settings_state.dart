part of 'settings_cubit.dart';

@immutable
class SettingsState {
  const SettingsState({
    this.themeMode = ThemeMode.system,
    this.appVersion = '',
    this.language = AppLanguage.system,
  });

  final ThemeMode themeMode;
  final String appVersion;
  final AppLanguage language;

  SettingsState copyWith({
    ThemeMode? themeMode,
    String? appVersion,
    AppLanguage? language,
  }) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      appVersion: appVersion ?? this.appVersion,
      language: language ?? this.language,
    );
  }
}
