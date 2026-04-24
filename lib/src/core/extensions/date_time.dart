import 'package:intl/intl.dart';

extension LocalizedDateTimeX on DateTime {
  DateTime get userLocal => toLocal();

  String formatForLocale(String localeName, {required String pattern}) {
    return DateFormat(pattern, localeName).format(userLocal);
  }
}
