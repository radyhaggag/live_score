part of 'settings_cubit.dart';

@immutable
/// Represents the settings state entity/model.
class SettingsState extends Equatable {
  const SettingsState({
    this.themeMode = ThemeMode.system,
    this.appVersion = '',
    this.language = AppLanguage.system,
  });

  final ThemeMode themeMode;
  final String appVersion;
  final AppLanguage language;

  /// Copy with.
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

  @override
  List<Object?> get props => [themeMode, appVersion, language];
}
