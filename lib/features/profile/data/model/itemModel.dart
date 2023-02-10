// import '../../../../core/data_source/model.dart';
//
// class Item extends BaseModel {
//   List<String>? images;
//   String? name;
//   String? description;
//   double? price;
//   List<String>? videos;
//
//   Item({this.images, this.name, this.description, this.price, this.videos});
//
//   Item.fromJson(Map<String, dynamic> json) {
//     images = json['images'].cast<String>();
//     name = json['name'];
//     description = json['description'];
//     if (json['price'] != null) price = double.parse(json['price'].toString());
//     videos = json['videos'].cast<String>();
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['images'] = this.images;
//     data['name'] = this.name;
//     data['description'] = this.description;
//     data['price'] = this.price;
//     data['videos'] = this.videos;
//     return data;
//   }
// }
