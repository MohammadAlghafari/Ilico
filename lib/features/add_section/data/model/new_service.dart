import 'package:charja_charity/core/data_source/model.dart';

import '../../../../core/responses/ApiResponse.dart';

class AddServiceResponse extends ApiResponse<AddService> {
  AddServiceResponse({required super.errors, required super.success, required super.data});

  factory AddServiceResponse.fromJson(Map<String, dynamic> json) {
    return AddServiceResponse(
        errors: json['message'], success: json['success'], data: AddService.fromJson(json['data']));
  }
}

class AddService extends BaseModel {
  String? name;
  String? description;
  int? price;
  List<String>? images;
  List<String>? videos;
  String? categoryId;

  AddService({this.name, this.description, this.price, this.images, this.videos, this.categoryId});

  AddService.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    price = json['price'];
    images = json['images'].cast<String>();
    videos = json['videos'].cast<String>();
    categoryId = json['categoryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['images'] = this.images;
    data['videos'] = this.videos;
    data['categoryId'] = this.categoryId;
    return data;
  }
}
