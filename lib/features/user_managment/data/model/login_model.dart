import 'package:charja_charity/core/data_source/model.dart';
import 'package:charja_charity/core/responses/ApiResponse.dart';
import 'package:charja_charity/features/user_managment/data/model/user_model.dart';

class LoginResponse extends ApiResponse<LoginModel> {
  LoginResponse({required super.errors, required super.success, required super.data});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(errors: json['message'], success: json['success'], data: LoginModel.fromJson(json['data']));
  }
}

class LoginModel extends BaseModel {
  String? accessToken;
  String? accessTokenExpirationDate;
  String? refreshToken;
  String? refreshTokenExpirationDate;
  String? userType;
  bool? isVerified;
  String? phoneNumber;
  String? userStatus;
  ChatUserModel? chatUserModel;

  LoginModel(
      {this.accessToken,
      this.userStatus,
      this.chatUserModel,
      this.accessTokenExpirationDate,
      this.refreshToken,
      this.refreshTokenExpirationDate,
      this.userType,
      this.isVerified,
      this.phoneNumber});

  LoginModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    accessTokenExpirationDate = json['accessTokenExpirationDate'];
    refreshToken = json['refreshToken'];
    refreshTokenExpirationDate = json['refreshTokenExpirationDate'];
    userType = json["userType"];
    isVerified = json['isVerified'];
    phoneNumber = json['phoneNumber'];
    userStatus = json["userStatus"];
    if (json['userChat'] != null) {
      chatUserModel = ChatUserModel.formJson(json['userChat']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    data['accessTokenExpirationDate'] = this.accessTokenExpirationDate;
    data['refreshToken'] = this.refreshToken;
    data['refreshTokenExpirationDate'] = this.refreshTokenExpirationDate;
    data['isVerified'] = this.isVerified;
    data['phoneNumber'] = this.phoneNumber;

    return data;
  }
}
