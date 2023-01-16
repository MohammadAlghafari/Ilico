import 'package:charja_charity/core/data_source/model.dart';

import '../../../../core/responses/ApiResponse.dart';

class SupscriptionResponse extends ApiResponse<SupscriptionList> {
  SupscriptionResponse(
      {required super.errors, required super.success, required super.data});

  factory SupscriptionResponse.fromJson(Map<String, dynamic> json) {
    return SupscriptionResponse(
        errors: json['message'],
        success: json['success'],
        data: SupscriptionList.fromJson(json));
  }
}

class SupscriptionList extends BaseModel {
  List<Supscription>? data;
  SupscriptionList({this.data});
  SupscriptionList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Supscription>[];
      json['data'].forEach((v) {
        data!.add(new Supscription.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Supscription extends BaseModel {
  String? id;
  String? title;
  String? description;
  int? price;
  int? duration;
  int? activityCount;
  bool isSelected = false;

  Supscription(
      {this.id,
      this.title,
      this.description,
      this.price,
      this.duration,
      this.activityCount,
      this.isSelected = false});

  Supscription.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    duration = json['duration'];
    activityCount = json['activityCount'];
    isSelected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['price'] = this.price;
    data['duration'] = this.duration;
    data['activityCount'] = this.activityCount;
    return data;
  }
}
