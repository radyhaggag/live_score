import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../features/settings/domain/app_language.dart';
import '../error/response_status.dart';

extension AppL10nBuildContext on BuildContext {
  S get l10n => S.of(this);

  String get localeName => Localizations.localeOf(this).languageCode;
}

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
