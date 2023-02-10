import 'package:charja_charity/core/data_source/model.dart';
import 'package:charja_charity/core/responses/ApiResponse.dart';

class ExampleResponse extends ApiResponse<ExampleModel> {
  ExampleResponse({required super.errors, required super.success, required super.data});

  factory ExampleResponse.fromJson(Map<String, dynamic> json) {
    return ExampleResponse(errors: json['errors'], success: json['success'], data: ExampleModel.fromJson(json['data']));
  }
}

class ExampleModel extends BaseModel {
  int? total;
  List<ExampleItem>? data;

  ExampleModel({this.total, this.data});

  ExampleModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['data'] != null) {
      data = <ExampleItem>[];
      json['data'].forEach((v) {
        data!.add(ExampleItem.fromJson(v));
      });
    }
  }
}

class ExampleItem extends BaseModel {
  String? id;
  String? name;
  String? code;
  String? icon;
  String? title;

  ExampleItem({this.id, this.name, this.code, this.icon, this.title});

  ExampleItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    icon = json['icon'];
    title = json['createdOn'];
  }
}
