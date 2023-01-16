import 'package:flutter/material.dart';

import 'base_validator.dart';

class MinLengthValidator extends BaseValidator {
  final int minLength;

  MinLengthValidator({required this.minLength});

  @override
  String getMessage(BuildContext context) {
    return ' ${('Min length')} $minLength ${('characters')}';
  }

  @override
  bool validate(String value) {
    return value.length >= minLength;
  }
}
