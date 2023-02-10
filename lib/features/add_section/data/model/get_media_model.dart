import 'package:charja_charity/features/add_section/data/model/add_media_model.dart';

import '../../../../core/data_source/model.dart';

class GetMediaList extends BaseModel {
  List<AddMediaModel>? data;
  GetMediaList({this.data});
  GetMediaList.fromJson(Map<String, dynamic> json) {
    if (json['response'] != null) {
      data = <AddMediaModel>[];
      json['response'].forEach((v) {
        data!.add(AddMediaModel.fromJson(v));
      });
    }
  }
}
