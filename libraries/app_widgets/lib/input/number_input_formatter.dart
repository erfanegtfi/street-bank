import 'package:app_utils/utils.dart';
import 'package:flutter/services.dart';

class NumberInputFormatter extends TextInputFormatter {
  NumberInputFormatter();

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    String newText = formatPrice(double.tryParse(newValue.text));
    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
