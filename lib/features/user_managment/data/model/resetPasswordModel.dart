import 'package:charja_charity/core/data_source/model.dart';

class ResetPasswordModel extends BaseModel {
  final String message;

  ResetPasswordModel({required this.message});

  factory ResetPasswordModel.fromJson(Map<String, dynamic> json) {
    return ResetPasswordModel(message: json['resetMyPassword']);
  }
}
