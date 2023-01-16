import 'package:flutter/material.dart';

import '../validators/base_validator.dart';

class InitPasswordValidator extends BaseValidator {
  @override
  String getMessage(BuildContext context) {
    return "";
  }

  @override
  bool validate(String value) {
    final regex = RegExp('(?=.*?[A-Za-z])(?=.*?[0-9])^.{8,}\$');
    return regex.hasMatch(value);
  }
}
