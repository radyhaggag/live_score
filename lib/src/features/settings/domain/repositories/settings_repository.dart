import 'package:flutter/material.dart';

import '../app_language.dart';

/// Contract for settings persistence operations.
///
/// Implementations handle reading/writing theme mode, language preference,
/// and app version retrieval.
abstract class SettingsRepository {
  /// Returns the persisted [ThemeMode], defaulting to [ThemeMode.system].
  Future<ThemeMode> getThemeMode();

  /// Persists the user's [ThemeMode] selection.
  Future<void> setThemeMode(ThemeMode themeMode);

  /// Returns the persisted [AppLanguage], defaulting to [AppLanguage.system].
  Future<AppLanguage> getAppLanguage();

  /// Persists the user's [AppLanguage] selection.
  Future<void> setAppLanguage(AppLanguage language);

  /// Returns the current app version string (e.g., `"1.0.0+1"`).
  Future<String> getAppVersion();
}
