import 'package:charja_charity/core/data_source/model.dart';
import 'package:charja_charity/features/profile/data/model/profile_model.dart';

//import 'package:charja_charity/features/profile/data/model/profile_model.dart';

import '../../../user_managment/data/model/user_model.dart';

class SPGeneralInformationModel extends BaseModel {
  String? photoUrl;
  String? userType;
  bool? isAvailable;
  bool? isEventProgress;
  GeneralInformation? generalInformation;
  List<Activities>? activities;
  Company? company;
  ChatUserModel? chatUserModel;

  SPGeneralInformationModel(
      {this.chatUserModel, this.photoUrl, this.isAvailable, this.generalInformation, this.activities, this.company});
  SPGeneralInformationModel.fromJson(Map<String, dynamic> json) {
    print(";;;;;;;;;kkkkkkk;;;;;;${json["isAvailable"]}");
    isAvailable = json["isAvailable"] ?? false;
    photoUrl = json['photoUrl'];
    userType = json['userType'];
    if (json['userChat'] != null) {
      chatUserModel = ChatUserModel.formJson(json['userChat']);
    }
    generalInformation =
        json['generalInformation'] != null ? new GeneralInformation.fromJson(json['generalInformation']) : null;
    if (json['activities'] != null) {
      activities = <Activities>[];
      json['activities'].forEach((v) {
        activities!.add(new Activities.fromJson(v));
      });
    }
    company = json['company'] != null ? new Company.fromJson(json['company']) : null;
    isEventProgress = json['isEventProgress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['photoUrl'] = this.photoUrl;
    data['isEventProgress'] = isEventProgress;
    if (this.generalInformation != null) {
      data['generalInformation'] = this.generalInformation!.toJson();
    }
    if (this.activities != null) {
      data['activities'] = this.activities!.map((v) => v.toJson()).toList();
    }
    if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
    return data;
  }
}
