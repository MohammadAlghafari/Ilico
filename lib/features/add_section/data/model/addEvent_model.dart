import 'package:charja_charity/core/data_source/model.dart';

class AddEventModel extends BaseModel {
  String? id;
  String? name;
  String? description;
  List<String>? images;
  List<String>? videos;
  String? startDate;
  String? endDate;
  AddEventModel({this.id, this.name, this.description, this.images, this.videos, this.startDate, this.endDate});
  AddEventModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    images = json['images'] != null ? json['images'].cast<String>() : [];
    videos = json["videos"] != null ? json["videos"].cast<String>() : [];
    startDate = json['startDate'];
    endDate = json['endDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['images'] = this.images;
    data['videos'] = this.videos;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    return data;
  }
}
