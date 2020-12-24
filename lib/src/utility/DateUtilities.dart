import 'package:intl/intl.dart';

class DateUtilities {
  static String formatDate(DateTime date) {
    final f = new DateFormat('yyyy-MM-dd hh:mm:ss');
    return f.format(date);
  }

  static String effectiveDate(DateTime date) {
    final f = new DateFormat('yyyy-MM-dd hh:mm');
    return f.format(date);
  }

  static String effectiveDateTime(DateTime date) {
    final f = new DateFormat().add_Hm();
    return f.format(date);
  }

  static String dateWithFormat(DateTime date, String format) {
    final f = new DateFormat(format);
    return f.format(date);
  }

  static String formatYear(DateTime date) {
    final f = new DateFormat('yyyy');
    return f.format(date);
  }
}
