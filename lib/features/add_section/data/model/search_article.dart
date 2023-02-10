import 'package:charja_charity/core/data_source/model.dart';

import '../../../profile/data/model/profile_model.dart';

class SearchList extends BaseModel {
  List<SearchArticle>? data;

  SearchList({this.data});

  SearchList.fromJson(Map<String, dynamic> json) {
    if (json['searchOfServiceProviderByName'] != null) {
      data = <SearchArticle>[];
      json['searchOfServiceProviderByName'].forEach((v) {
        data!.add(new SearchArticle.fromJson(v));
      });
    } else {
      if (json['searchOfInfluencerByName'] != null) {
        data = <SearchArticle>[];
        json['searchOfInfluencerByName'].forEach((v) {
          data!.add(new SearchArticle.fromJson(v));
        });
      }
    }
  }
}

class SearchArticle extends BaseModel {
  String? id;
  GeneralInformation? generalInformation;

  SearchArticle({this.id, this.generalInformation});

  SearchArticle.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    generalInformation =
        json['generalInformation'] != null ? GeneralInformation.fromJson(json['generalInformation']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.generalInformation != null) {
      data['generalInformation'] = this.generalInformation!.toJson();
    }
    return data;
  }
}

// class GeneralInformation {
//   String? firstName;
//
//   GeneralInformation({this.firstName});
//
//   GeneralInformation.fromJson(Map<String, dynamic> json) {
//     firstName = json['firstName'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['firstName'] = this.firstName;
//     return data;
//   }
// }
