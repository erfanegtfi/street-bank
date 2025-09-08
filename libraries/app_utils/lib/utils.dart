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

String formatPrice(String price) {
  price = price.replaceAll(",", "");
  num value = num.tryParse(price) ?? 0;
  bool isNegative = value < 0;
  value = value.abs();

  // Check if number has decimals
  bool hasDecimals = value % 1 != 0;

  String numStr = hasDecimals
      ? value.toStringAsFixed(2) // keep 2 decimals
      : value.toStringAsFixed(0); // no decimals

  List<String> parts = numStr.split('.');
  String integerPart = parts[0];
  String decimalPart = parts.length > 1 ? parts[1] : "";

  // Add commas to integer part
  StringBuffer buffer = StringBuffer();
  int count = 0;
  for (int i = integerPart.length - 1; i >= 0; i--) {
    buffer.write(integerPart[i]);
    count++;
    if (count % 3 == 0 && i != 0) {
      buffer.write(',');
    }
  }
  String formattedInt = buffer.toString().split('').reversed.join('');

  // Rebuild final number
  String result = hasDecimals ? "$formattedInt.$decimalPart" : formattedInt;

  // Add negative sign back if needed
  return isNegative ? "-$result" : result;
}

String getRandomID() {
  var uuid = Uuid();
  return uuid.v4();
}
