import 'package:flutter/material.dart';

import '../validators/base_validator.dart';

class PasswordValidator extends BaseValidator {
  @override
  String getMessage(BuildContext context) {
    return ('password must be 12 character at least and contain letters (upper and lower case) and numbers and special character');
  }

  @override
  bool validate(String value) {
    final regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{10,}$');
    return regex.hasMatch(value);
  }
}
