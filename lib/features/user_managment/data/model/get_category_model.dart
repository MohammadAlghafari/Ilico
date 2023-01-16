import 'package:charja_charity/core/data_source/model.dart';
import 'package:charja_charity/core/responses/ApiResponse.dart';

import '../../../profile/data/model/profile_model.dart';

class CategoriesResponse extends ApiResponse<CategoryList> {
  CategoriesResponse({required super.errors, required super.success, required super.data});

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) {
    return CategoriesResponse(errors: json['errors'], success: json['success'], data: CategoryList.fromJson(json));
  }
}

class CategoryList extends BaseModel {
  CategoryList({this.data});
  List<Activities>? data;

  CategoryList.fromJson(Map<String, dynamic> json) {
    data = [];
    json['data'].forEach((element) {
      data?.add(Activities.fromJson(element));
    });
  }
}
