import 'package:charja_charity/core/data_source/model.dart';

class DeleteEventModel extends BaseModel {
  final String message;

  DeleteEventModel({required this.message});

  factory DeleteEventModel.fromJson(Map<String, dynamic> json) {
    return DeleteEventModel(message: json['deleteEvent']);
  }
}
