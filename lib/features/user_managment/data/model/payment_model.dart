import 'package:charja_charity/core/data_source/model.dart';

import '../../../../core/responses/ApiResponse.dart';

class PaymentResponse extends ApiResponse<payment> {
  PaymentResponse({required super.errors, required super.success, required super.data});

  factory PaymentResponse.fromJson(Map<String, dynamic> json) {
    return PaymentResponse(errors: json['message'], success: json['success'], data: payment.fromJson(json['data']));
  }
}

class payment extends BaseModel {
  String? packageId;
  String? paymentMethodId;

  payment({this.packageId, this.paymentMethodId});

  payment.fromJson(Map<String, dynamic> json) {
    packageId = json['packageId'];
    paymentMethodId = json['paymentMethodId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['packageId'] = this.packageId;
    data['paymentMethodId'] = this.paymentMethodId;
    return data;
  }
}
