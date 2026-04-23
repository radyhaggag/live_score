// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Live Score`
  String get appName {
    return Intl.message('Live Score', name: 'appName', desc: '', args: []);
  }

  /// `No route found`
  String get noRouteFound {
    return Intl.message(
      'No route found',
      name: 'noRouteFound',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Fixtures`
  String get fixtures {
    return Intl.message('Fixtures', name: 'fixtures', desc: '', args: []);
  }

  /// `Standings`
  String get standings {
    return Intl.message('Standings', name: 'standings', desc: '', args: []);
  }

  /// `Live Score`
  String get liveScore {
    return Intl.message('Live Score', name: 'liveScore', desc: '', args: []);
  }

  /// `vs`
  String get versus {
    return Intl.message('vs', name: 'versus', desc: '', args: []);
  }

  /// `Statistics`
  String get statistics {
    return Intl.message('Statistics', name: 'statistics', desc: '', args: []);
  }

  /// `Lineups`
  String get lineups {
    return Intl.message('Lineups', name: 'lineups', desc: '', args: []);
  }

  /// `Events`
  String get events {
    return Intl.message('Events', name: 'events', desc: '', args: []);
  }

  /// `Assist`
  String get assist {
    return Intl.message('Assist', name: 'assist', desc: '', args: []);
  }

  /// `View Fixtures`
  String get viewFixtures {
    return Intl.message(
      'View Fixtures',
      name: 'viewFixtures',
      desc: '',
      args: [],
    );
  }

  /// `View Standings`
  String get viewStandings {
    return Intl.message(
      'View Standings',
      name: 'viewStandings',
      desc: '',
      args: [],
    );
  }

  /// `Live Fixtures`
  String get liveFixtures {
    return Intl.message(
      'Live Fixtures',
      name: 'liveFixtures',
      desc: '',
      args: [],
    );
  }

  /// `View All`
  String get viewAll {
    return Intl.message('View All', name: 'viewAll', desc: '', args: []);
  }

  /// `Reload`
  String get reload {
    return Intl.message('Reload', name: 'reload', desc: '', args: []);
  }

  /// `Statistics are not available yet`
  String get noStats {
    return Intl.message(
      'Statistics are not available yet',
      name: 'noStats',
      desc: '',
      args: [],
    );
  }

  /// `Lineups are not available yet`
  String get noLineups {
    return Intl.message(
      'Lineups are not available yet',
      name: 'noLineups',
      desc: '',
      args: [],
    );
  }

  /// `Events are not available yet`
  String get noEvents {
    return Intl.message(
      'Events are not available yet',
      name: 'noEvents',
      desc: '',
      args: [],
    );
  }

  /// `No matches scheduled today`
  String get noFixtures {
    return Intl.message(
      'No matches scheduled today',
      name: 'noFixtures',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Appearance`
  String get appearance {
    return Intl.message('Appearance', name: 'appearance', desc: '', args: []);
  }

  /// `Choose how the app looks across every screen.`
  String get appearanceDescription {
    return Intl.message(
      'Choose how the app looks across every screen.',
      name: 'appearanceDescription',
      desc: '',
      args: [],
    );
  }

  /// `App Version`
  String get appVersion {
    return Intl.message('App Version', name: 'appVersion', desc: '', args: []);
  }

  /// `System default`
  String get systemDefault {
    return Intl.message(
      'System default',
      name: 'systemDefault',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get light {
    return Intl.message('Light', name: 'light', desc: '', args: []);
  }

  /// `Dark`
  String get dark {
    return Intl.message('Dark', name: 'dark', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Choose the app language or follow your device language.`
  String get languageDescription {
    return Intl.message(
      'Choose the app language or follow your device language.',
      name: 'languageDescription',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message('English', name: 'english', desc: '', args: []);
  }

  /// `Arabic`
  String get arabic {
    return Intl.message('Arabic', name: 'arabic', desc: '', args: []);
  }

  /// `Top Stats`
  String get topStats {
    return Intl.message('Top Stats', name: 'topStats', desc: '', args: []);
  }

  /// `Team`
  String get teamName {
    return Intl.message('Team', name: 'teamName', desc: '', args: []);
  }

  /// `Form`
  String get form {
    return Intl.message('Form', name: 'form', desc: '', args: []);
  }

  /// `PL`
  String get playedShort {
    return Intl.message('PL', name: 'playedShort', desc: '', args: []);
  }

  /// `W`
  String get wonShort {
    return Intl.message('W', name: 'wonShort', desc: '', args: []);
  }

  /// `D`
  String get drawnShort {
    return Intl.message('D', name: 'drawnShort', desc: '', args: []);
  }

  /// `L`
  String get lostShort {
    return Intl.message('L', name: 'lostShort', desc: '', args: []);
  }

  /// `GF`
  String get goalsForShort {
    return Intl.message('GF', name: 'goalsForShort', desc: '', args: []);
  }

  /// `GA`
  String get goalsAgainstShort {
    return Intl.message('GA', name: 'goalsAgainstShort', desc: '', args: []);
  }

  /// `GD`
  String get goalDifferenceShort {
    return Intl.message('GD', name: 'goalDifferenceShort', desc: '', args: []);
  }

  /// `Pts`
  String get pointsShort {
    return Intl.message('Pts', name: 'pointsShort', desc: '', args: []);
  }

  /// `TBD`
  String get tbd {
    return Intl.message('TBD', name: 'tbd', desc: '', args: []);
  }

  /// `LIVE`
  String get liveFallback {
    return Intl.message('LIVE', name: 'liveFallback', desc: '', args: []);
  }

  /// `Aggregate ({homeScore} - {awayScore})`
  String aggregateScore(Object homeScore, Object awayScore) {
    return Intl.message(
      'Aggregate ($homeScore - $awayScore)',
      name: 'aggregateScore',
      desc: '',
      args: [homeScore, awayScore],
    );
  }

  /// `Round {number}`
  String roundNumber(Object number) {
    return Intl.message(
      'Round $number',
      name: 'roundNumber',
      desc: '',
      args: [number],
    );
  }

  /// `Season {number}`
  String seasonNumber(Object number) {
    return Intl.message(
      'Season $number',
      name: 'seasonNumber',
      desc: '',
      args: [number],
    );
  }

  /// `Something went wrong while loading details. Please try again.`
  String get errorClientClosedRequest {
    return Intl.message(
      'Something went wrong while loading details. Please try again.',
      name: 'errorClientClosedRequest',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong. Please try again later.`
  String get errorInternalServerError {
    return Intl.message(
      'Something went wrong. Please try again later.',
      name: 'errorInternalServerError',
      desc: '',
      args: [],
    );
  }

  /// `Connection timed out. Please check your internet and try again.`
  String get errorNetworkConnectError {
    return Intl.message(
      'Connection timed out. Please check your internet and try again.',
      name: 'errorNetworkConnectError',
      desc: '',
      args: [],
    );
  }

  /// `Flutter Web needs a server-side proxy for this API.`
  String get errorWebProxyRequired {
    return Intl.message(
      'Flutter Web needs a server-side proxy for this API.',
      name: 'errorWebProxyRequired',
      desc: '',
      args: [],
    );
  }

  /// `Unexpected error.`
  String get errorUnexpected {
    return Intl.message(
      'Unexpected error.',
      name: 'errorUnexpected',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
