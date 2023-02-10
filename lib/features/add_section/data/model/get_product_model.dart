import '../../../../core/data_source/model.dart';
import '../../../../core/responses/ApiResponse.dart';
import 'new_service.dart';

class GetProductResponse extends ApiResponse<GetProductList> {
  GetProductResponse({required super.errors, required super.success, required super.data});

  factory GetProductResponse.fromJson(Map<String, dynamic> json) {
    return GetProductResponse(errors: json['message'], success: json['success'], data: GetProductList.fromJson(json));
  }
}

class GetProductList extends BaseModel {
  List<AddService>? data;
  GetProductList({this.data});
  GetProductList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <AddService>[];
      json['data'].forEach((v) {
        data!.add(AddService.fromJson(v));
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
//
// class GetproductModel extends BaseModel {
//   String? id;
//   String? name;
//   String? description;
//   double? price;
//   List<String>? images;
//   List<String>? videos;
//   bool? isActive;
//   Category? category;
//   String? createdAt;
//   String? updatedAt;
//
//   GetproductModel(
//       {this.id,
//       this.name,
//       this.description,
//       this.price,
//       this.images,
//       this.videos,
//       this.isActive,
//       this.category,
//       this.createdAt,
//       this.updatedAt});
//
//   GetproductModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     description = json['description'];
//     price = double.parse(json['price'].toString());
//     if (json['images'] != null) {
//       images = <String>[];
//       json['images'].forEach((v) {
//         images!.add(v);
//       });
//     }
//     //images = json['images'].cast<String>();
//     if (json['videos'] != null) {
//       videos = <String>[];
//       json['videos'].forEach((v) {
//         videos!.add(v);
//       });
//     }
//     isActive = json['isActive'];
//     category = json['category'] != null ? new Category.fromJson(json['category']) : null;
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['description'] = this.description;
//     data['price'] = this.price;
//     data['images'] = this.images;
//     data['videos'] = this.videos;
//     // data['categoryId'] = this.categoryId;
//     return data;
//   }
// }

class Category {
  String? id;
  String? name;
  String? description;
  bool? isActive;

  Category({this.id, this.name, this.description, this.isActive});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['isActive'] = this.isActive;

    return data;
  }
}
/*


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
  String? id;
  String? name;
  String? description;
  int? price;
  List<String>? images;
  List<String>? videos;

  String? categoryId;

  GetproductModel({this.id, this.name, this.description, this.price, this.images, this.videos, this.categoryId});

  GetproductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    images = json['images'].cast<String>();
    videos = json['videos'].cast<String>();
    categoryId = json['categoryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['images'] = this.images;
    data['videos'] = this.videos;
    // data['categoryId'] = this.categoryId;
    return data;
  }
}
class category {
  Category? category;

  category({this.category});

  category.fromJson(Map<String, dynamic> json) {
    category = json['category'] != null ? new Category.fromJson(json['category']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    return data;
  }
}

class Category extends baseModel{
  String? id;
  String? name;
  String? description;
  bool? isActive;


  Category({this.id, this.name, this.description, this.isActive, this.tags});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    isActive = json['isActive'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['isActive'] = this.isActive;

    return data;
  }
}
*/
