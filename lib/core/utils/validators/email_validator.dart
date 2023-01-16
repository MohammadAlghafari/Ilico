import 'package:flutter/material.dart';

import '../validators/base_validator.dart';

class EmailValidator extends BaseValidator {
  @override
  String getMessage(BuildContext context) {
    return 'Invalid email';
  }

  @override
  bool validate(String value) {
    final regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{1,}))$');
    return regex.hasMatch(value.trim());
  }
}
