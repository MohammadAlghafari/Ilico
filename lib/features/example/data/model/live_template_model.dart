import 'package:charja_charity/core/responses/ApiResponse.dart';
import 'package:charja_charity/features/example/data/model/example_model.dart';

class LiveTemplateResponse extends ApiResponse<ExampleModel> {
  LiveTemplateResponse({required super.errors, required super.success, required super.data});

  factory LiveTemplateResponse.fromJson(Map<String, dynamic> json) {
    return LiveTemplateResponse(
        errors: json['errors'], success: json['success'], data: ExampleModel.fromJson(json['data']));
  }
}
