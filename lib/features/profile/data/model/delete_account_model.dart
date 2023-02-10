import '../../../../core/data_source/model.dart';

class DeleteAccountModel extends BaseModel {
  final String message;

  DeleteAccountModel({required this.message});

  factory DeleteAccountModel.fromJson(Map<String, dynamic> json) {
    return DeleteAccountModel(message: json['deleteMyAccount']);
  }
}
