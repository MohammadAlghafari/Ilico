import 'package:intl/intl.dart';

class DateHelper {
  static DateTime convertStringDateToDateTime(String dateInUtc) {
    return DateFormat("yyyy-MM-ddTHH:mm:ss").parse(dateInUtc, true);
  }

  static String convertDateDisplay(String date, {String? format}) {
    final DateFormat displayFormatter = DateFormat(format ?? 'yyyy-MM-dd HH:mm');
    final DateTime displayDate = convertStringDateToDateTime(date);
    final String formatted = displayFormatter.format(displayDate);
    return formatted;
  }

  static String convertDateTimeToDisplay(DateTime date, {String? format}) {
    final DateFormat displayFormatter = DateFormat(format ?? 'yyyy-MM-dd HH:mm');
    final String formatted = displayFormatter.format(date);
    return formatted;
  }
}
