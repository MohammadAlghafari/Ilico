import 'package:flutter/material.dart';

import 'base_validator.dart';

class PhoneNumberValidator extends BaseValidator {
  PhoneNumberValidator();

  @override
  String getMessage(BuildContext context) {
    return 'Please enter a valid phone number';
  }

  @override
  bool validate(String value) {
    final regex = RegExp(r'^(?:[+0]9)?[0-9]{10,}$');
    return regex.hasMatch(value);
  }
}
