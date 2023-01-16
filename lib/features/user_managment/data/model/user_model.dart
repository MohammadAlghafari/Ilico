import 'package:charja_charity/core/data_source/model.dart';

import '../../../../core/responses/ApiResponse.dart';

class UserInfoResponse extends ApiResponse<UserModel> {
  UserInfoResponse(
      {required super.errors, required super.success, required super.data});

  factory UserInfoResponse.fromJson(Map<String, dynamic> json) {
    return UserInfoResponse(
        errors: json['message'],
        success: json['success'],
        data: UserModel.fromJson(json['data']));
  }
}

class UserModel extends BaseModel {
  String? id;
  String? email;
  String? name;
  String? dob;
  String? gender;
  String? postalCode;
  String? address;
  String? cityId;
  String? photoUrl;
  String? passportNumber;
  String? phoneNumber;
  String? userStatus;
  bool? isVerified;
  Influencer? customer;
  Influencer? influencer;
  ServiceProvider? serviceProvider;
  Influencer? admin;
  String? hashRefreshToken;
  String? webFcmToken;
  String? mobileFcmToken;
  String? lastLogin;
  String? createdAt;
  String? updatedAt;
  String? userType;

  UserModel(
      {this.id,
      this.email,
      this.name,
      this.dob,
      this.userType,
      this.gender,
      this.postalCode,
      this.address,
      this.cityId,
      this.photoUrl,
      this.passportNumber,
      this.phoneNumber,
      this.userStatus,
      this.isVerified,
      this.customer,
      this.influencer,
      this.serviceProvider,
      this.admin,
      this.hashRefreshToken,
      this.webFcmToken,
      this.mobileFcmToken,
      this.lastLogin,
      this.createdAt,
      this.updatedAt});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    dob = json['dob'];
    gender = json['gender'];
    postalCode = json['postalCode'];
    address = json['address'];
    cityId = json['cityId'];
    photoUrl = json['photoUrl'];
    passportNumber = json['passportNumber'];
    phoneNumber = json['phoneNumber'];
    userStatus = json['userStatus'];
    isVerified = json['isVerified'];
    userType = json['userType'];
    customer = json['customer'] != null
        ? new Influencer.fromJson(json['customer'])
        : null;
    influencer = json['influencer'] != null
        ? new Influencer.fromJson(json['influencer'])
        : null;
    serviceProvider = json['serviceProvider'] != null
        ? new ServiceProvider.fromJson(json['serviceProvider'])
        : null;
    admin =
        json['admin'] != null ? new Influencer.fromJson(json['admin']) : null;
    hashRefreshToken = json['hashRefreshToken'];
    webFcmToken = json['webFcmToken'];
    mobileFcmToken = json['mobileFcmToken'];
    lastLogin = json['lastLogin'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
}

class Customer {
  String? id;
  GeneralInformation? generalInformation;
  GeneralInformation? address;
  Null? photoUrl;
  String? userStatus;

  Customer(
      {this.id,
      this.generalInformation,
      this.address,
      this.photoUrl,
      this.userStatus});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    generalInformation = json['generalInformation'] != null
        ? new GeneralInformation.fromJson(json['generalInformation'])
        : null;
    address = json['address'] != null
        ? new GeneralInformation.fromJson(json['address'])
        : null;
    photoUrl = json['photoUrl'];
    userStatus = json['userStatus'];
  }
}

class GeneralInformation {
  String? email;
  String? name;
  Null? dob;
  Null? gender;
  String? phoneNumber;

  GeneralInformation(
      {this.email, this.name, this.dob, this.gender, this.phoneNumber});

  GeneralInformation.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    dob = json['dob'];
    gender = json['gender'];
    phoneNumber = json['phoneNumber'];
  }
}

class Address {
  Null? address;
  Null? cityId;
  Null? postalCode;

  Address({this.address, this.cityId, this.postalCode});

  Address.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    cityId = json['cityId'];
    postalCode = json['postalCode'];
  }
}

class Influencer {
  GeneralInformation? generalInformation;
  GeneralInformation? address;

  Influencer({this.generalInformation, this.address});

  Influencer.fromJson(Map<String, dynamic> json) {
    generalInformation = json['generalInformation'] != null
        ? new GeneralInformation.fromJson(json['generalInformation'])
        : null;
    address = json['address'] != null
        ? new GeneralInformation.fromJson(json['address'])
        : null;
  }
}

class ServiceProvider {
  GeneralInformation? generalInformation;
  GeneralInformation? address;
  Influencer? customer;

  ServiceProvider({this.generalInformation, this.address, this.customer});

  ServiceProvider.fromJson(Map<String, dynamic> json) {
    generalInformation = json['generalInformation'] != null
        ? new GeneralInformation.fromJson(json['generalInformation'])
        : null;
    address = json['address'] != null
        ? new GeneralInformation.fromJson(json['address'])
        : null;
    customer = json['customer'] != null
        ? new Influencer.fromJson(json['customer'])
        : null;
  }
}
