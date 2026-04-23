import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepositoryImpl {
  static const _themeModeKey = 'theme_mode';

  Future<ThemeMode> getThemeMode() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? storedThemeMode = preferences.getString(_themeModeKey);

    return switch (storedThemeMode) {
      'dark' => ThemeMode.dark,
      'light' => ThemeMode.light,
      _ => ThemeMode.system,
    };
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String value = switch (themeMode) {
      ThemeMode.dark => 'dark',
      ThemeMode.light => 'light',
      ThemeMode.system => 'system',
    };
    await preferences.setString(_themeModeKey, value);
  }

  Future<String> getAppVersion() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return '${packageInfo.version}+${packageInfo.buildNumber}';
  }
}
