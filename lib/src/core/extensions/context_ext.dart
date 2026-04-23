import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../features/settings/domain/app_language.dart';
import '../error/response_status.dart';
import '../theme/app_colors_extension.dart';

/// Consolidated [BuildContext] extensions for screen metrics, theming,
/// and localization access.
extension ContextExtension on BuildContext {
  // ── Screen Metrics ──────────────────────────────────────────────

  /// Full screen width (equivalent to `MediaQuery.sizeOf(this).width`).
  double get screenWidth => MediaQuery.sizeOf(this).width;

  /// Full screen height (equivalent to `MediaQuery.sizeOf(this).height`).
  double get screenHeight => MediaQuery.sizeOf(this).height;

  // ── Theme Shortcuts ──────────────────────────────────────────────

  /// Shortcut for `Theme.of(context).colorScheme`.
  ColorScheme get colors => Theme.of(this).colorScheme;

  /// Shortcut for `Theme.of(context).extension<AppColorsExtension>()!`.
  AppColorsExtension get colorsExt =>
      Theme.of(this).extension<AppColorsExtension>()!;

  /// Shortcut for `Theme.of(context).textTheme`.
  TextTheme get textTheme => Theme.of(this).textTheme;

  // ── Localization ────────────────────────────────────────────────

  /// Shortcut for `S.of(context)` — generated l10n accessor.
  S get l10n => S.of(this);

  /// Current locale's language code (e.g., `'en'` or `'ar'`).
  String get localeName => Localizations.localeOf(this).languageCode;
}

/// Helper extensions on the generated [S] class.
extension AppL10nHelpers on S {
  String bottomNavigationTitle(int index) {
    return switch (index) {
      0 => liveScore,
      1 => fixtures,
      2 => standings,
      _ => liveScore,
    };
  }

  String themeModeLabel(ThemeMode mode) {
    return switch (mode) {
      ThemeMode.system => systemDefault,
      ThemeMode.light => light,
      ThemeMode.dark => dark,
    };
  }

  String languageLabel(AppLanguage language) {
    return switch (language) {
      AppLanguage.system => systemDefault,
      AppLanguage.english => english,
      AppLanguage.arabic => arabic,
    };
  }

  String errorMessage(String key) {
    return switch (key) {
      StatusMessage.clientClosedRequestKey => errorClientClosedRequest,
      StatusMessage.internalServerErrorKey => errorInternalServerError,
      StatusMessage.networkConnectErrorKey => errorNetworkConnectError,
      StatusMessage.webProxyRequiredKey => errorWebProxyRequired,
      _ => errorUnexpected,
    };
  }
}
