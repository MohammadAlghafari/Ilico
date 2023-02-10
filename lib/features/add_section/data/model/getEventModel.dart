import 'package:charja_charity/features/add_section/data/model/addEvent_model.dart';

import '../../../../core/data_source/model.dart';

class GetEventList extends BaseModel {
  List<AddEventModel>? data;
  GetEventList({this.data});
  GetEventList.fromJson(Map<String, dynamic> json) {
    if (json['response'] != null) {
      data = <AddEventModel>[];
      json['response'].forEach((v) {
        data!.add(AddEventModel.fromJson(v));
      });
    }
  }
}
//
// class GetEventModel extends BaseModel {
//   String? id;
//   String? name;
//   String? description;
//   String? startDate;
//   String? endDate;
//   List<String>? images;
//   List<String>? videos;
//   bool? isActive;
//
//   GetEventModel({
//     this.id,
//     this.name,
//     this.description,
//     this.startDate,
//     this.endDate,
//     this.images,
//     this.videos,
//     this.isActive,
//   });
//
//   GetEventModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     description = json['description'];
//     startDate = json['startDate'];
//     endDate = json['endDate'];
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
//   }
// }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['description'] = this.description;
//     data['price'] = this.price;
//     if (this.images != null) {
//       data['images'] = this.images!.map((v) => v).toList();
//     }
//
//     if (this.videos != null) {
//       data['videos'] = this.videos!.map((v) => v).toList();
//     }
//     data['isActive'] = this.isActive;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//
//     return data;
//   }
// }
// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = new Map<String, dynamic>();
//   data['id'] = this.id;
//   data['name'] = this.name;
//   data['description'] = this.description;
//   data['price'] = this.price;
//   data['images'] = this.images;
//   data['videos'] = this.videos;
//   // data['categoryId'] = this.categoryId;
//   return data;
// }
