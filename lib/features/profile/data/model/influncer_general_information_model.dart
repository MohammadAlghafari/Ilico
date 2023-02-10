import 'package:charja_charity/core/data_source/model.dart';

import '../../../profile/data/model/profile_model.dart';

class InfluncerGeneralInformationModel extends BaseModel {
  String? photoUrl;
  String? userType;
  bool? isFav;
  GeneralInformation? generalInformation;
  List<Activities>? categories;
  String? facebookUrl;
  int? facebookFollowers;
  String? youtubeUrl;
  int? youtubeFollowers;
  String? tiktokUrl;
  int? tiktokFollowers;
  String? instagramUrl;
  int? instagramFollowers;
  String? twitterUrl;
  int? twitterFollowers;
  InfluncerGeneralInformationModel(
      {this.photoUrl,
      this.userType,
      this.isFav,
      this.generalInformation,
      this.categories,
      this.facebookUrl,
      this.facebookFollowers,
      this.youtubeUrl,
      this.youtubeFollowers,
      this.tiktokUrl,
      this.tiktokFollowers,
      this.instagramUrl,
      this.instagramFollowers,
      this.twitterUrl,
      this.twitterFollowers});

  InfluncerGeneralInformationModel.fromJson(Map<String, dynamic> json) {
    photoUrl = json['photoUrl'];
    userType = json['userType'];
    generalInformation =
        json['generalInformation'] != null ? new GeneralInformation.fromJson(json['generalInformation']) : null;
    if (json['categories'] != null) {
      categories = <Activities>[];
      json['categories'].forEach((v) {
        categories!.add(new Activities.fromJson(v));
      });
    }
    isFav = json['isFavorite'];
    facebookUrl = json['facebookUrl'];
    facebookFollowers = json['facebookFollowers'];
    youtubeUrl = json['youtubeUrl'];
    youtubeFollowers = json['youtubeFollowers'];
    tiktokUrl = json['tiktokUrl'];
    tiktokFollowers = json['tiktokFollowers'];
    instagramUrl = json['instagramUrl'];
    instagramFollowers = json['instagramFollowers'];
    twitterUrl = json['twitterUrl'];
    twitterFollowers = json['twitterFollowers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['photoUrl'] = this.photoUrl;
    data['userType'] = this.userType;
    if (this.generalInformation != null) {
      data['generalInformation'] = this.generalInformation!.toJson();
    }
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    data['isFavorite'] = this.isFav;
    data['facebookUrl'] = this.facebookUrl;
    data['facebookFollowers'] = this.facebookFollowers;
    data['youtubeUrl'] = this.youtubeUrl;
    data['youtubeFollowers'] = this.youtubeFollowers;
    data['tiktokUrl'] = this.tiktokUrl;
    data['tiktokFollowers'] = this.tiktokFollowers;
    data['instagramUrl'] = this.instagramUrl;
    data['instagramFollowers'] = this.instagramFollowers;
    data['twitterUrl'] = this.twitterUrl;
    data['twitterFollowers'] = this.twitterFollowers;
    return data;
  }
}
