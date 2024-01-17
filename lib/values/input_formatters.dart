import 'package:flutter/services.dart';

final onlyDecimalDigits = CustomFormatter.allow(RegExp(r'[0-9.,]'));
final decimalFormatter = TextInputFormatter.withFunction((oldValue, newValue) {
  final text = newValue.text;
  return text.isEmpty
      ? newValue
      : !RegExp(r"^[0-9]{1,3}([.,][0-9]?)?$").hasMatch(text)
          ? oldValue
          : newValue;
});

class CustomFormatter extends FilteringTextInputFormatter {
  CustomFormatter.allow(Pattern filterPattern) : super.allow(filterPattern);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final updatedValue = super.formatEditUpdate(oldValue, newValue);

    return updatedValue.text.isEmpty && newValue.text.isNotEmpty
        ? oldValue
        : updatedValue;
  }
}
