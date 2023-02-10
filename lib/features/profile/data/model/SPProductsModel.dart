import 'package:charja_charity/features/add_section/data/model/new_service.dart';

import '../../../../core/data_source/model.dart';

class SPProduct extends BaseModel {
  List<AddService>? products;

  SPProduct({this.products});

  SPProduct.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <AddService>[];
      json['products'].forEach((v) {
        products!.add(new AddService.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
