part of 'settings_cubit.dart';

@immutable
class SettingsState {
  const SettingsState({this.themeMode = ThemeMode.light, this.appVersion = ''});

  final ThemeMode themeMode;
  final String appVersion;

  SettingsState copyWith({ThemeMode? themeMode, String? appVersion}) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      appVersion: appVersion ?? this.appVersion,
    );
  }
}
