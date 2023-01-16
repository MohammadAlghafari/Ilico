import 'package:flutter/material.dart';

import 'base_validator.dart';

class LengthValidator extends BaseValidator {
  final int length;

  LengthValidator({required this.length});

  @override
  String getMessage(BuildContext context) {
    return ' ${('length')} $length ${('characters')}';
  }

  @override
  bool validate(String value) {
    return value.length == length || value.length < length;
  }
}
