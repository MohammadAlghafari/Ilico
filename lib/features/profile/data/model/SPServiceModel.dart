import '../../../../core/data_source/model.dart';
import '../../../add_section/data/model/new_service.dart';

class SPService extends BaseModel {
  List<AddService>? services;

  SPService({this.services});

  SPService.fromJson(Map<String, dynamic> json) {
    if (json['services'] != null) {
      services = <AddService>[];
      json['services'].forEach((v) {
        services!.add(new AddService.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
