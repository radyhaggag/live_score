import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/app_language.dart';
import '../../domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  static const _themeModeKey = 'theme_mode';
  static const _appLanguageKey = 'app_language';

  @override
  Future<ThemeMode> getThemeMode() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? storedThemeMode = preferences.getString(_themeModeKey);

    return switch (storedThemeMode) {
      'dark' => ThemeMode.dark,
      'light' => ThemeMode.light,
      _ => ThemeMode.system,
    };
  }

  @override
  Future<void> setThemeMode(ThemeMode themeMode) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String value = switch (themeMode) {
      ThemeMode.dark => 'dark',
      ThemeMode.light => 'light',
      ThemeMode.system => 'system',
    };
    await preferences.setString(_themeModeKey, value);
  }

  @override
  Future<AppLanguage> getAppLanguage() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return AppLanguage.fromStorage(preferences.getString(_appLanguageKey));
  }

  @override
  Future<void> setAppLanguage(AppLanguage language) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(_appLanguageKey, language.storageValue);
  }

  @override
  Future<String> getAppVersion() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return '${packageInfo.version}+${packageInfo.buildNumber}';
  }
}
