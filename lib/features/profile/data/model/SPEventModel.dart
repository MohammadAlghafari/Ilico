import 'package:charja_charity/core/data_source/model.dart';

import '../../../add_section/data/model/addEvent_model.dart';

class SPEvent extends BaseModel {
  List<AddEventModel>? event;

  SPEvent({this.event});

  SPEvent.fromJson(Map<String, dynamic> json) {
    if (json['events'] != null) {
      event = <AddEventModel>[];
      json['events'].forEach((v) {
        event!.add(new AddEventModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.event != null) {
      data['events'] = this.event!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
