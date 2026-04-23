import 'dart:ui' as ui;

import 'package:flutter/material.dart';

enum AppLanguage {
  system('system'),
  english('en'),
  arabic('ar');

  const AppLanguage(this.storageValue);

  final String storageValue;

  static AppLanguage fromStorage(String? value) {
    return AppLanguage.values.firstWhere(
      (language) => language.storageValue == value,
      orElse: () => AppLanguage.system,
    );
  }

  Locale? get localeOrNull {
    return switch (this) {
      AppLanguage.system => null,
      AppLanguage.english => const Locale('en'),
      AppLanguage.arabic => const Locale('ar'),
    };
  }

  Locale resolveLocale([Locale? deviceLocale]) {
    if (localeOrNull case final locale?) {
      return locale;
    }

    final Locale locale = deviceLocale ?? ui.PlatformDispatcher.instance.locale;
    return locale.languageCode.toLowerCase() == 'ar'
        ? const Locale('ar')
        : const Locale('en');
  }
}
