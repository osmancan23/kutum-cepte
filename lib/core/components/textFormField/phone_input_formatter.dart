import 'package:flutter/services.dart';

class PhoneInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Sadece rakamları al
    var numbers = newValue.text.replaceAll(RegExp('[^0-9]'), '');

    // Eğer ilk rakam 5 ise başına 0 ekle
    if (numbers.isNotEmpty && numbers[0] == '5') {
      numbers = '0$numbers';
    }

    // Maksimum 11 rakam (başındaki 0 dahil)
    if (numbers.length > 11) {
      numbers = numbers.substring(0, 11);
    }

    // Format: 05XX XXX XX XX
    var formatted = '';
    for (var i = 0; i < numbers.length; i++) {
      if (i == 0) {
        // İlk rakam 0 değilse izin verme
        if (numbers[i] != '0') continue;
      }
      if (i == 1) {
        // İkinci rakam 5 değilse izin verme
        if (numbers[i] != '5') continue;
      }
      if (i == 4 || i == 7 || i == 9) {
        formatted += ' ';
      }
      formatted += numbers[i];
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
