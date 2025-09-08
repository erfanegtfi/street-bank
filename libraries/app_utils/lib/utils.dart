import 'package:intl/intl.dart';

String _emailPattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
int _passwordMinLength = 6;

bool checkEmailValidation(String value) {
  RegExp regExp = RegExp(_emailPattern);
  if (value.isEmpty == true) return false;
  return regExp.hasMatch(value.trim());
}

bool checkPasswordValidation(String value) {
  return value.trim().length >= _passwordMinLength;
}

String formatPriceWithTwoDecimals(num? value) {
  if (value == null) return "0";
  // double truncated = (value * 100).truncateToDouble() / 100;

  final number = NumberFormat("#,##0.00", "en_US");
  return number.format(value);
}
