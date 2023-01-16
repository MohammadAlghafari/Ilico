import 'package:charja_charity/core/data_source/model.dart';
import 'package:charja_charity/core/responses/ApiResponse.dart';

import 'example_model.dart';

class SubjectResponse extends ApiResponse<ExampleModel> {
  SubjectResponse({required super.errors, required super.success, required super.data});

  factory SubjectResponse.fromJson(Map<String, dynamic> json) {
    return SubjectResponse(errors: json['errors'], success: json['success'], data: ExampleModel.fromJson(json['data']));
  }
}

class Subject extends BaseModel {
  String? id;
  String? name;

  Subject({this.id, this.name});

  Subject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
