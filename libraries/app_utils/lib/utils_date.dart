import 'package:intl/intl.dart';

class UtilsDate {
  static final String serverDateTimePattern = "yyyy-MM-dd'T'HH:mm:ssZ";
  static final String appDateTimePattern = "yyyy-MM-dd HH:MM:ss";

  static String formatDate(String? date) {
    if (date == null) return "";
    var dateTime = DateFormat(serverDateTimePattern);
    final dt = dateTime.parse(date, true).toLocal();

    String formattedDate = DateFormat(appDateTimePattern).format(dt);
    return formattedDate;
  }
}
