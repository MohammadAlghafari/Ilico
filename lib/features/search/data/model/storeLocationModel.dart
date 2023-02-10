import '../../../../core/data_source/model.dart';

class StoreLocation extends BaseModel {
  final String message;

  StoreLocation({required this.message});

  factory StoreLocation.fromJson(Map<String, dynamic> json) {
    return StoreLocation(message: json['updateUserLocation']);
  }
}
