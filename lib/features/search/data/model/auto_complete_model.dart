import 'package:charja_charity/core/data_source/model.dart';

class GetAutoCompleteList extends BaseModel {
  List<AutoCompleteSearchItem>? data;
  GetAutoCompleteList({this.data});
  GetAutoCompleteList.fromJson(Map<String, dynamic> json) {
    if (json['response'] != null) {
      data = <AutoCompleteSearchItem>[];
      json['response'].forEach((v) {
        data!.add(AutoCompleteSearchItem.fromJson(v));
      });
    }
  }
}

class AutoCompleteSearchItem extends BaseModel {
  String? id;
  String? name;

  AutoCompleteSearchItem({
    this.name,
    this.id,
  });
  factory AutoCompleteSearchItem.fromJson(Map<String, dynamic> json) {
    return AutoCompleteSearchItem(
      name: json['name'],
      id: json['id'],
    );
  }
}
