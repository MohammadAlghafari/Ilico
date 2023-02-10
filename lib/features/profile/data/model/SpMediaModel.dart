import 'package:charja_charity/core/data_source/model.dart';
import 'package:charja_charity/features/add_section/data/model/add_media_model.dart';

class SPGallery extends BaseModel {
  List<AddMediaModel>? media;

  SPGallery({this.media});

  SPGallery.fromJson(Map<String, dynamic> json) {
    if (json['gallery'] != null) {
      media = <AddMediaModel>[];
      json['gallery'].forEach((v) {
        media!.add(new AddMediaModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.media != null) {
      data['gallery'] = this.media!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
