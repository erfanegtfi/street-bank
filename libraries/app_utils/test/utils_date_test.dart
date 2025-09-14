import 'package:app_utils/utils_date.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

void main() {
  group('UtilsDate.formatDate', () {
    test('Returns empty string when input is null', () {
      expect(UtilsDate.formatDate(null), '');
    });

    test('Formats server date string to app pattern', () {
      const serverDate = "2025-09-13T14:30:00+0000"; // UTC
      final formatted = UtilsDate.formatDate(serverDate);

      // Parse expected result manually
      final dt = DateFormat(UtilsDate.serverDateTimePattern).parse(serverDate, true).toLocal();
      final expected = DateFormat(UtilsDate.appDateTimePattern).format(dt);

      expect(formatted, expected);
    });
    test('Returns current date in server pattern', () {
      final result = UtilsDate.getCurrentDate();

      // Just check if it parses correctly with the same formatter
      final formatter = DateFormat(UtilsDate.serverDateTimePattern);
      expect(() => formatter.parse(result), returnsNormally);
    });
  });
}
