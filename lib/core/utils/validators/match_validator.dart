import 'package:flutter/material.dart';

import 'base_validator.dart';

class MatchValidator extends BaseValidator {
  String value;

  MatchValidator({required this.value});

  @override
  String getMessage(BuildContext context) {
    return ('Not matched');
  }

  @override
  bool validate(String value) {
    debugPrint('const value: ${this.value}');
    debugPrint('var value: $value');
    return value == this.value;
  }
}
