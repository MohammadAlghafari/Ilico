import 'package:flutter/material.dart';

import '../validators/base_validator.dart';

class PasswordValidator extends BaseValidator {
  @override
  String getMessage(BuildContext context) {
    return ('password must be 10 character at least and contain letters (upper and lower case) and numbers and special character');
  }

  @override
  bool validate(String value) {
    final regex = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*\W)');
    return regex.hasMatch(value);
  }
}
