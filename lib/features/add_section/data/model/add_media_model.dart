import 'package:charja_charity/core/data_source/model.dart';

class AddMediaModel extends BaseModel {
  String? media;
  String? type;
  String? id;
  AddMediaModel({required this.media, required this.type, this.id}) : super(id: id);
  AddMediaModel.fromJson(Map<String, dynamic> json) {
    media = json['media'];
    type = json['type'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['media'] = this.media;
    data['type'] = this.type;
    data['id'] = this.id;
    return data;
  }
}
