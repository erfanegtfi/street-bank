import 'package:uuid/uuid.dart';

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

String _formatWithCommas(num? value) {
  if (value == null) return "0";
  String numStr = value.toString();
  StringBuffer buffer = StringBuffer();

  int count = 0;
  for (int i = numStr.length - 1; i >= 0; i--) {
    buffer.write(numStr[i]);
    count++;
    if (count % 3 == 0 && i != 0) {
      buffer.write(',');
    }
  }
  return buffer.toString().split('').reversed.join('');
}

String formatPrice(num? value) {
  if (value == null) return "0";
  List<String> parts = value.toString().split('.');

  if (parts.length == 2) {
    String numStr = value.toStringAsFixed(2); // keep 2 decimals

    String integerPart = parts[0];
    String decimalPart = parts[1];

    String formattedInt = _formatWithCommas(int.parse(integerPart));
    return "$formattedInt.$decimalPart";
  } else {
    return _formatWithCommas(value);
  }
}

String getRandomID() {
  var uuid = Uuid();
  return uuid.v4();
}
