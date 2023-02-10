import 'package:charja_charity/core/data_source/model.dart';

import '../../../../core/responses/ApiResponse.dart';
import 'get_product_model.dart';

class AddServiceResponse extends ApiResponse<AddService> {
  AddServiceResponse({required super.errors, required super.success, required super.data});

  factory AddServiceResponse.fromJson(Map<String, dynamic> json) {
    return AddServiceResponse(
        errors: json['message'], success: json['success'], data: AddService.fromJson(json['data']));
  }
}

class AddService extends BaseModel {
  String? id;
  String? name;
  String? description;
  double? price;
  List<String>? images;
  List<String>? videos;
  //String? categoryId;
  Category? category;

  AddService({
    this.id,
    this.name,
    this.description,
    this.price,
    this.images,
    this.videos,
    this.category,
  });

  AddService.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = double.parse(json['price'].toString());
    images = (json['images'] != null ? json['images'].cast<String>() : []);
    videos = (json['videos'] != null ? json['videos'].cast<String>() : []);
    category = json['category'] != null ? new Category.fromJson(json['category']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['images'] = this.images;
    data['videos'] = this.videos;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }

    return data;
  }
}
