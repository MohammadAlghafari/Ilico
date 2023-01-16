import 'package:charja_charity/core/data_source/model.dart';

import '../../../../core/responses/ApiResponse.dart';

class UploadFileResponse extends ApiResponse<FileData> {
  UploadFileResponse({required super.errors, required super.success, required super.data});

  factory UploadFileResponse.fromJson(Map<String, dynamic> json) {
    return UploadFileResponse(errors: json['message'], success: json['success'], data: FileData.fromJson(json));
  }
}

class FileData extends BaseModel {
  List<Data>? data;

  FileData({this.data});

  FileData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? url;
  String? key;

  Data({this.url, this.key});

  Data.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['key'] = this.key;
    return data;
  }
}
