import 'package:charja_charity/core/data_source/model.dart';

import '../../../profile/data/model/profile_model.dart';
import '../../../search/data/model/search_model.dart';

class GetArticle extends BaseModel {
  List<GetMyArticles>? data;

  GetArticle({this.data});

  GetArticle.fromJson(Map<String, dynamic> json) {
    if (json['response'] != null) {
      data = <GetMyArticles>[];
      json['response'].forEach((v) {
        data!.add(GetMyArticles.fromJson(v));
      });
    }
  }
}

class CreateArticle extends BaseModel {
  GetMyArticles? data;
  CreateArticle({this.data});
  CreateArticle.fromJson(Map<String, dynamic> json) {
    json['createArticle'] != null ? GetMyArticles.fromJson(json['createArticle']) : null;
  }
}

class GetMyArticles extends BaseModel {
  String? id;
  String? title;
  String? text;
  String? createdAt;
  List<String>? images;
  List<String>? videos;
  SearchOfServiceProvider? serviceProvider;
  ProfileInfluencerModel? influencer;

  GetMyArticles({this.id, this.title, this.text, this.images, this.videos, this.serviceProvider, this.influencer})
      : super(id: id);

  GetMyArticles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    text = json['text'];
    createdAt = json['createdAt'];
    influencer = json["influencer"] != null ? ProfileInfluencerModel.fromJson(json['influencer']) : null;
    images = json['images'] != null ? json['images'].cast<String>() : null;
    videos = json["videos"] != null ? json["videos"].cast<String>() : null;
    serviceProvider =
        json['serviceProvider'] != null ? SearchOfServiceProvider.fromJson(json['serviceProvider']) : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['text'] = this.text;
    data['createdAt'] = this.createdAt;
    data['images'] = this.images;
    data['videos'] = this.videos;

    return data;
  }
}
