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
  Set<Activities>? tempData;

  // Set<Activities>? allActivites;

  // Set<Activities>? recentActivites;

  CategoryList.fromJson(Map<String, dynamic> json) {
    tempData = {};
    data = [];
    //  allActivites = {};
    // if (json['data']['allCategories'].length > 0) {

    json['data']['recent'].forEach((element) {
      tempData?.add(Activities.fromJson(element));
    });
    tempData!.forEach((element) {
      element.isSelected = true;
    });

    json['data']['allCategories'].forEach((element) {
      tempData?.add(Activities.fromJson(element));
    });
    data = tempData!.toList();

    // print(data.toString());
//    }
  }
}
