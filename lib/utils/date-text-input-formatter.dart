import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

/// Format incoming numeric text to fit the format of dd/MM/yyyy
class DateTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final int newLen = newValue.text.length;
    int selectionIndex = newValue.selection.end;

    int qtdTotalBarras = newValue.text.split('').where((e) => e == '/').length;

    final StringBuffer newText = StringBuffer();
    for (int i = 0; i < newValue.text.length; i++) {
      int qtdBarras = newValue.text.substring(0, i).split('').where((e) => e == '/').length;
      newText.write(newValue.text.substring(i + qtdBarras, i + qtdBarras + 1));

      if (newText.toString().length == 2) {
        newText.write('/');
        selectionIndex++;
      }
    }

    selectionIndex += qtdTotalBarras;
    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
