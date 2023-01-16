import '../../../../core/data_source/model.dart';
import '../../../../core/responses/ApiResponse.dart';

class GetProductResponse extends ApiResponse<GetProductList> {
  GetProductResponse({required super.errors, required super.success, required super.data});

  factory GetProductResponse.fromJson(Map<String, dynamic> json) {
    return GetProductResponse(errors: json['message'], success: json['success'], data: GetProductList.fromJson(json));
  }
}

class GetProductList extends BaseModel {
  List<GetproductModel>? data;
  GetProductList({this.data});
  GetProductList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <GetproductModel>[];
      json['data'].forEach((v) {
        data!.add(GetproductModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class GetproductModel extends BaseModel {
  String? name;
  String? description;
  int? price;
  List<String>? images;
  List<String>? videos;

  String? categoryId;

  GetproductModel({this.name, this.description, this.price, this.images, this.videos, this.categoryId});

  GetproductModel.fromJson(Map<String, dynamic> json) {
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
    // data['categoryId'] = this.categoryId;
    return data;
  }
}
