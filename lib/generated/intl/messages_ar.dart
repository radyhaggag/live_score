// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ar locale. All the
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
  String get localeName => 'ar';

  static String m0(homeScore, awayScore) =>
      "النتيجة الإجمالية (${homeScore} - ${awayScore})";

  static String m1(number) => "الجولة ${number}";

  static String m2(number) => "الموسم ${number}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "aggregateScore": m0,
    "all": MessageLookupByLibrary.simpleMessage("الكل"),
    "allLeaguesTooltip": MessageLookupByLibrary.simpleMessage("كل الدوريات"),
    "appName": MessageLookupByLibrary.simpleMessage("لايف سكور"),
    "appVersion": MessageLookupByLibrary.simpleMessage("إصدار التطبيق"),
    "appearance": MessageLookupByLibrary.simpleMessage("المظهر"),
    "appearanceDescription": MessageLookupByLibrary.simpleMessage(
      "اختَر شكل التطبيق في كل الشاشات.",
    ),
    "arabic": MessageLookupByLibrary.simpleMessage("العربية"),
    "assist": MessageLookupByLibrary.simpleMessage("صناعة هدف"),
    "dark": MessageLookupByLibrary.simpleMessage("داكن"),
    "drawnShort": MessageLookupByLibrary.simpleMessage("ت"),
    "english": MessageLookupByLibrary.simpleMessage("الإنجليزية"),
    "errorClientClosedRequest": MessageLookupByLibrary.simpleMessage(
      "حدثت مشكلة أثناء تحميل التفاصيل. حاول مرة أخرى.",
    ),
    "errorInternalServerError": MessageLookupByLibrary.simpleMessage(
      "حدث خطأ ما. حاول مرة أخرى لاحقاً.",
    ),
    "errorLoadFixtures": MessageLookupByLibrary.simpleMessage(
      "تعذر تحميل المباريات حالياً.",
    ),
    "errorLoadStandings": MessageLookupByLibrary.simpleMessage(
      "تعذر تحميل الترتيب حالياً.",
    ),
    "errorNetworkConnectError": MessageLookupByLibrary.simpleMessage(
      "انتهت مهلة الاتصال. تأكد من الإنترنت ثم حاول مرة أخرى.",
    ),
    "errorUnexpected": MessageLookupByLibrary.simpleMessage(
      "حدث خطأ غير متوقع.",
    ),
    "errorWebProxyRequired": MessageLookupByLibrary.simpleMessage(
      "نسخة الويب من Flutter تحتاج إلى Proxy للخادم لهذا الـ API.",
    ),
    "events": MessageLookupByLibrary.simpleMessage("الأحداث"),
    "fixtures": MessageLookupByLibrary.simpleMessage("المباريات"),
    "form": MessageLookupByLibrary.simpleMessage("النتائج"),
    "fullLineups": MessageLookupByLibrary.simpleMessage("التشكيل الكامل"),
    "goalDifferenceShort": MessageLookupByLibrary.simpleMessage("فارق"),
    "goalsAgainstShort": MessageLookupByLibrary.simpleMessage("عليه"),
    "goalsForShort": MessageLookupByLibrary.simpleMessage("له"),
    "home": MessageLookupByLibrary.simpleMessage("الرئيسية"),
    "language": MessageLookupByLibrary.simpleMessage("اللغة"),
    "languageDescription": MessageLookupByLibrary.simpleMessage(
      "اختَر لغة التطبيق أو اجعله يتبع لغة الجهاز.",
    ),
    "light": MessageLookupByLibrary.simpleMessage("فاتح"),
    "lineups": MessageLookupByLibrary.simpleMessage("التشكيل"),
    "liveFallback": MessageLookupByLibrary.simpleMessage("مباشر"),
    "liveFixtures": MessageLookupByLibrary.simpleMessage("المباريات المباشرة"),
    "liveScore": MessageLookupByLibrary.simpleMessage("لايف سكور"),
    "lostShort": MessageLookupByLibrary.simpleMessage("خ"),
    "noEvents": MessageLookupByLibrary.simpleMessage(
      "لا توجد أحداث متاحة حالياً",
    ),
    "noFixtures": MessageLookupByLibrary.simpleMessage("لا توجد مباريات اليوم"),
    "noLineups": MessageLookupByLibrary.simpleMessage(
      "لا يوجد تشكيل متاح حالياً",
    ),
    "noRouteFound": MessageLookupByLibrary.simpleMessage("الصفحة غير موجودة"),
    "noStandingsYet": MessageLookupByLibrary.simpleMessage(
      "لا يوجد ترتيب متاح حالياً.",
    ),
    "noStats": MessageLookupByLibrary.simpleMessage(
      "لا توجد إحصائيات متاحة حالياً",
    ),
    "playedShort": MessageLookupByLibrary.simpleMessage("لعب"),
    "pointsShort": MessageLookupByLibrary.simpleMessage("نقاط"),
    "reload": MessageLookupByLibrary.simpleMessage("إعادة المحاولة"),
    "roundNumber": m1,
    "seasonNumber": m2,
    "settings": MessageLookupByLibrary.simpleMessage("الإعدادات"),
    "standings": MessageLookupByLibrary.simpleMessage("الترتيب"),
    "statistics": MessageLookupByLibrary.simpleMessage("الإحصائيات"),
    "systemDefault": MessageLookupByLibrary.simpleMessage("حسب الجهاز"),
    "tbd": MessageLookupByLibrary.simpleMessage("لاحقاً"),
    "teamName": MessageLookupByLibrary.simpleMessage("الفريق"),
    "topStats": MessageLookupByLibrary.simpleMessage("أبرز الإحصائيات"),
    "versus": MessageLookupByLibrary.simpleMessage("ضد"),
    "viewAll": MessageLookupByLibrary.simpleMessage("عرض الكل"),
    "viewFixtures": MessageLookupByLibrary.simpleMessage("عرض المباريات"),
    "viewStandings": MessageLookupByLibrary.simpleMessage("عرض الترتيب"),
    "wonShort": MessageLookupByLibrary.simpleMessage("ف"),
  };
}
