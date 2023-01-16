import 'package:charja_charity/core/data_source/model.dart';
import 'package:charja_charity/core/responses/ApiResponse.dart';
import 'package:charja_charity/core/utils/cashe_helper.dart';

class ProfileResponse extends ApiResponse<UserInfo> {
  ProfileResponse({required super.errors, required super.success, required super.data});

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(errors: json['message'], success: json['success'], data: getModel(json));
  }

  static getModel(Map<String, dynamic> json) {
    String? type = CashHelper.getRole();
    print(';;;;;;;;;;;;;;;;;;;;Role is ${type}');
    if (type == "Customer") {
      return ProfileCustomerModel.fromJson(json['data']);
    } else if (type == 'Influencer') {
      return ProfileInfluencerModel.fromJson(json['data']);
    } else if (type == 'ServiceProvider') {
      return ProfileSpModel.fromJson(json['data']);
    }
  }
}

class CompanyResponse extends ApiResponse<Company> {
  CompanyResponse({required super.errors, required super.success, required super.data});

  factory CompanyResponse.fromJson(Map<String, dynamic> json) {
    return CompanyResponse(
        errors: json['errors'] ?? [], success: json['success'], data: Company.fromJson(json['data']));
  }
}

abstract class UserInfo extends BaseModel {
  UserInfo(
      {this.id,
      this.address,
      this.photoUrl,
      this.userStatus,
      this.completePercent,
      this.generalInformation,
      this.activities});

  final String? id;
  final Address? address;
  late final String? photoUrl;
  final String? userStatus;
  final int? completePercent;
  final GeneralInformation? generalInformation;
  final List<Activities>? activities;
}

class ProfileCustomerModel extends UserInfo {
  ProfileCustomerModel({
    String? id,
    GeneralInformation? generalInformation,
    Address? address,
    String? photoUrl,
    String? userStatus,
    int? completePercent,
    List<Activities>? activities,
  }) : super(
            id: id,
            address: address,
            completePercent: completePercent,
            photoUrl: photoUrl,
            userStatus: userStatus,
            generalInformation: generalInformation,
            activities: activities);

  factory ProfileCustomerModel.fromJson(Map<String, dynamic> json) {
    return ProfileCustomerModel(
      id: json['id'],
      generalInformation:
          json['generalInformation'] != null ? GeneralInformation.fromJson(json['generalInformation']) : null,
      address: json['address'] != null ? Address.fromJson(json['address']) : null,
      photoUrl: json['photoUrl'],
      userStatus: json['userStatus'],
      completePercent: json['completePercent'],
      activities: json['categories'] != null ? Activities.getActivities(json['categories']) : null,
    );
  }
}

class ProfileInfluencerModel extends UserInfo {
  ProfileInfluencerModel(
      {String? id,
      GeneralInformation? generalInformation,
      Address? address,
      String? photoUrl,
      String? userStatus,
      int? completePercent,
      List<Activities>? activities,
      this.twitterUrl,
      this.twitterFollowers,
      this.facebookFollowers,
      this.facebookUrl,
      this.youtubeFollowers,
      this.youtubeUrl,
      this.instagramFollowers,
      this.instagramUrl,
      this.tiktokUrl,
      this.tiktokFollowers,
      this.snapchatFollowers,
      this.snapchatUrl})
      : super(
            id: id,
            address: address,
            completePercent: completePercent,
            photoUrl: photoUrl,
            userStatus: userStatus,
            generalInformation: generalInformation,
            activities: activities);

  String? facebookUrl;
  int? facebookFollowers;
  String? instagramUrl;
  int? instagramFollowers;
  String? tiktokUrl;
  int? tiktokFollowers;
  String? youtubeUrl;
  int? youtubeFollowers;
  String? twitterUrl;
  int? twitterFollowers;
  String? snapchatUrl;
  int? snapchatFollowers;

  factory ProfileInfluencerModel.fromJson(Map<String, dynamic> json) {
    return ProfileInfluencerModel(
      id: json['id'],
      generalInformation:
          json['generalInformation'] != null ? GeneralInformation.fromJson(json['generalInformation']) : null,
      address: json['address'] != null ? Address.fromJson(json['address']) : null,
      photoUrl: json['photoUrl'],
      userStatus: json['userStatus'],
      completePercent: json['completePercent'],
      facebookUrl: json['facebookUrl'],
      facebookFollowers: json['facebookFollowers'],
      tiktokFollowers: json['tiktokFollowers'],
      tiktokUrl: json['tiktokUrl'],
      instagramUrl: json['instagramUrl'],
      instagramFollowers: json['instagramFollowers'],
      youtubeUrl: json['youtubeUrl'],
      youtubeFollowers: json['youtubeFollowers'],
      twitterUrl: json['twitterUrl'],
      twitterFollowers: json['twitterFollowers'],
      snapchatUrl: json['snapchatUrl'],
      snapchatFollowers: json['snapchatFollowers'],
      activities: json['categories'] != null ? Activities.getActivities(json['categories']) : null,
    );
  }
}

class ProfileSpModel extends UserInfo {
  bool? isCustomer;
  bool? isAvailable;
  String? stripeCustomerId;
  Customer? customerModel;
  Company? companyModel;

  ProfileSpModel({
    String? id,
    GeneralInformation? generalInformation,
    Address? address,
    String? photoUrl,
    String? userStatus,
    int? completePercent,
    List<Activities>? activities,
    this.customerModel,
    this.isAvailable,
    this.companyModel,
    this.isCustomer,
    this.stripeCustomerId,
  }) : super(
            id: id,
            address: address,
            completePercent: completePercent,
            photoUrl: photoUrl,
            userStatus: userStatus,
            generalInformation: generalInformation,
            activities: activities);

  factory ProfileSpModel.fromJson(Map<String, dynamic> json) {
    return ProfileSpModel(
      id: json['id'],
      generalInformation:
          json['generalInformation'] != null ? GeneralInformation.fromJson(json['generalInformation']) : null,
      address: json['address'] != null ? Address.fromJson(json['address']) : null,
      photoUrl: json['photoUrl'],
      userStatus: json['userStatus'],
      completePercent: json['completePercent'],
      isCustomer: json['isCustomer'],
      isAvailable: json['isAvailable'],
      stripeCustomerId: json['stripeCustomerId'],
      customerModel: json['customer'] != null ? Customer.fromJson(json['customer']) : null,
      companyModel: json['company'] != null ? Company.fromJson(json['company']) : null,
      activities: json['activities'] != null ? Activities.getActivities(json['activities']) : null,
    );
  }
}

class GeneralInformation {
  String? email;
  String? firstName;
  String? lastName;
  String? dob;
  String? gender;
  String? phoneNumber;

  GeneralInformation({this.email, this.firstName, this.lastName, this.dob, this.gender, this.phoneNumber});

  GeneralInformation.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    dob = json['dob'];
    gender = json['gender'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['email'] = email;
    data['firstName'] = firstName;
    data['lastName'];
    data['dob'] = dob;
    data['gender'] = gender;
    data['phoneNumber'] = phoneNumber;
    return data;
  }
}

class Address {
  String? address;
  String? cityId;
  String? postalCode;
  String? country;
  String? state;

  Address({this.address, this.cityId, this.postalCode, this.state, this.country});

  Address.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    cityId = json['cityId'];
    postalCode = json['postalCode'];
    country = json['country'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['cityId'] = this.cityId;
    data['postalCode'] = this.postalCode;
    data['state'] = this.state;
    data['country'] = this.country;
    return data;
  }
}

class Customer {
  Customer({this.generalInformation, this.id});

  String? id;
  GeneralInformation? generalInformation;

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    generalInformation =
        json['generalInformation'] != null ? GeneralInformation.fromJson(json['generalInformation']) : null;
  }
}

class Company extends BaseModel {
  String? id;
  String? name;
  String? description;
  String? job;
  String? phoneNumber;
  String? iban;
  String? sirenNumber;

  Company({this.phoneNumber, this.name, this.id, this.description, this.iban, this.job, this.sirenNumber});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    job = json['job'];
    phoneNumber = json['phoneNumber'];
    iban = json['iban'];
    sirenNumber = json['sirenNumber'];
  }
}

class Activities extends BaseModel {
  String? id;
  String? name;
  String? description;
  bool? isActive;
  late bool isSelected;
  Activities({this.id, this.name, this.description, this.isSelected = false, this.isActive});

  Activities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    isActive = json['isActive'];
    isSelected = false;
  }
  static getActivities(List json) {
    List<Activities> activities = <Activities>[];
    json.forEach((v) {
      activities.add(Activities.fromJson(v));
    });
    return activities;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    return data;
  }
}
