// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(homeScore, awayScore) =>
      "Aggregate (${homeScore} - ${awayScore})";

  static String m1(number) => "Round ${number}";

  static String m2(number) => "Season ${number}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "aggregateScore": m0,
    "all": MessageLookupByLibrary.simpleMessage("All"),
    "allLeaguesTooltip": MessageLookupByLibrary.simpleMessage("All leagues"),
    "appName": MessageLookupByLibrary.simpleMessage("Live Score"),
    "appVersion": MessageLookupByLibrary.simpleMessage("App Version"),
    "appearance": MessageLookupByLibrary.simpleMessage("Appearance"),
    "appearanceDescription": MessageLookupByLibrary.simpleMessage(
      "Choose how the app looks across every screen.",
    ),
    "arabic": MessageLookupByLibrary.simpleMessage("Arabic"),
    "assist": MessageLookupByLibrary.simpleMessage("Assist"),
    "dark": MessageLookupByLibrary.simpleMessage("Dark"),
    "drawnShort": MessageLookupByLibrary.simpleMessage("D"),
    "english": MessageLookupByLibrary.simpleMessage("English"),
    "errorClientClosedRequest": MessageLookupByLibrary.simpleMessage(
      "Something went wrong while loading details. Please try again.",
    ),
    "errorInternalServerError": MessageLookupByLibrary.simpleMessage(
      "Something went wrong. Please try again later.",
    ),
    "errorLoadFixtures": MessageLookupByLibrary.simpleMessage(
      "Unable to load fixtures right now.",
    ),
    "errorLoadStandings": MessageLookupByLibrary.simpleMessage(
      "Unable to load standings right now.",
    ),
    "errorNetworkConnectError": MessageLookupByLibrary.simpleMessage(
      "Connection timed out. Please check your internet and try again.",
    ),
    "errorUnexpected": MessageLookupByLibrary.simpleMessage(
      "Unexpected error.",
    ),
    "errorWebProxyRequired": MessageLookupByLibrary.simpleMessage(
      "Flutter Web needs a server-side proxy for this API.",
    ),
    "events": MessageLookupByLibrary.simpleMessage("Events"),
    "fixtures": MessageLookupByLibrary.simpleMessage("Fixtures"),
    "form": MessageLookupByLibrary.simpleMessage("Form"),
    "goalDifferenceShort": MessageLookupByLibrary.simpleMessage("GD"),
    "goalsAgainstShort": MessageLookupByLibrary.simpleMessage("GA"),
    "goalsForShort": MessageLookupByLibrary.simpleMessage("GF"),
    "home": MessageLookupByLibrary.simpleMessage("Home"),
    "language": MessageLookupByLibrary.simpleMessage("Language"),
    "languageDescription": MessageLookupByLibrary.simpleMessage(
      "Choose the app language or follow your device language.",
    ),
    "light": MessageLookupByLibrary.simpleMessage("Light"),
    "lineups": MessageLookupByLibrary.simpleMessage("Lineups"),
    "liveFallback": MessageLookupByLibrary.simpleMessage("LIVE"),
    "liveFixtures": MessageLookupByLibrary.simpleMessage("Live Fixtures"),
    "liveScore": MessageLookupByLibrary.simpleMessage("Live Score"),
    "lostShort": MessageLookupByLibrary.simpleMessage("L"),
    "noEvents": MessageLookupByLibrary.simpleMessage(
      "Events are not available yet",
    ),
    "noFixtures": MessageLookupByLibrary.simpleMessage(
      "No matches scheduled today",
    ),
    "noLineups": MessageLookupByLibrary.simpleMessage(
      "Lineups are not available yet",
    ),
    "noRouteFound": MessageLookupByLibrary.simpleMessage("No route found"),
    "noStandingsYet": MessageLookupByLibrary.simpleMessage(
      "No standings available yet.",
    ),
    "noStats": MessageLookupByLibrary.simpleMessage(
      "Statistics are not available yet",
    ),
    "playedShort": MessageLookupByLibrary.simpleMessage("PL"),
    "pointsShort": MessageLookupByLibrary.simpleMessage("Pts"),
    "reload": MessageLookupByLibrary.simpleMessage("Reload"),
    "roundNumber": m1,
    "seasonNumber": m2,
    "settings": MessageLookupByLibrary.simpleMessage("Settings"),
    "standings": MessageLookupByLibrary.simpleMessage("Standings"),
    "statistics": MessageLookupByLibrary.simpleMessage("Statistics"),
    "systemDefault": MessageLookupByLibrary.simpleMessage("System default"),
    "tbd": MessageLookupByLibrary.simpleMessage("TBD"),
    "teamName": MessageLookupByLibrary.simpleMessage("Team"),
    "topStats": MessageLookupByLibrary.simpleMessage("Top Stats"),
    "versus": MessageLookupByLibrary.simpleMessage("vs"),
    "viewAll": MessageLookupByLibrary.simpleMessage("View All"),
    "viewFixtures": MessageLookupByLibrary.simpleMessage("View Fixtures"),
    "viewStandings": MessageLookupByLibrary.simpleMessage("View Standings"),
    "wonShort": MessageLookupByLibrary.simpleMessage("W"),
  };
}
