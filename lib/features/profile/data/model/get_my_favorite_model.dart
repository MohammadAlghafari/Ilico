import 'package:charja_charity/features/profile/data/model/profile_model.dart';

import '../../../../core/data_source/model.dart';
import '../../../search/data/model/search_model.dart';

class GetMyFavoriteListModel extends BaseModel {
  List<MyFavorietModel>? favorites;

  GetMyFavoriteListModel({this.favorites});

  GetMyFavoriteListModel.fromJson(Map<String, dynamic> json) {
    if (json['getMyFavorite'] != null) {
      favorites = <MyFavorietModel>[];
      json['getMyFavorite'].forEach((v) {
        favorites!.add(MyFavorietModel.fromJson(v));
      });
    }
  }
}

class MyFavorietModel extends BaseModel {
  String? id;
  SearchOfServiceProvider? serviceProvider;
  ProfileInfluencerModel? influencerModel;

  MyFavorietModel({this.id, this.serviceProvider, this.influencerModel});

  MyFavorietModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceProvider =
        json['serviceProvider'] != null ? SearchOfServiceProvider.fromJson(json['serviceProvider']) : null;
    influencerModel = json['influencer'] != null ? ProfileInfluencerModel.fromJson(json['influencer']) : null;
  }
}
