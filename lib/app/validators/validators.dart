import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

extension Validators on Validatorless{

  static FormFieldValidator compare(TextEditingController? valueEC, String message) {
    return (value) {
      final secondValue = valueEC?.text ?? '';

      if (value == null && (value != null && value != secondValue)) {
        return message;
      }
      return null;
    };
  }

}