import 'package:charja_charity/core/data_source/model.dart';

class ToggleFavoriteResult extends BaseModel {
  String? id;
  String? type;

  ToggleFavoriteResult({this.id, this.type});

  ToggleFavoriteResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
  }
}
