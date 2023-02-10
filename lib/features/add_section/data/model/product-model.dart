// import 'package:charja_charity/core/data_source/model.dart';
//
// class ProductModel extends BaseModel {
//   ProductModel({required this.products});
//   Products products;
//
//   factory ProductModel.fromJson(Map<String, dynamic> json) {
//     print('from product modelsvsdvsdv ');
//     print(json);
//     return ProductModel(
//         // errors: json['message'],
//         // success: json['success'],
//         products: Products.fromJson(json['products']));
//   }
// }
//
// class Products extends BaseModel {
//   List<Edges>? edges;
//
//   Products({this.edges});
//
//   Products.fromJson(Map<String, dynamic> json) {
//     print('from edges');
//     if (json['edges'] != null) {
//       edges = <Edges>[];
//       json['edges'].forEach((v) {
//         edges!.add(new Edges.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.edges != null) {
//       data['edges'] = this.edges!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Edges {
//   Node? node;
//
//   Edges({this.node});
//
//   Edges.fromJson(Map<String, dynamic> json) {
//     print('from edge model');
//     node = json['node'] != null ? new Node.fromJson(json['node']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.node != null) {
//       data['node'] = this.node!.toJson();
//     }
//     return data;
//   }
// }
//
// class Node {
//   String? id;
//   String? name;
//   String? description;
//   //repeater
//
//   Node({this.id, this.name, this.description});
//
//   Node.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     description = json['description'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['description'] = this.description;
//     return data;
//   }
// }
