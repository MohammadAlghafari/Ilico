import 'package:charja_charity/core/data_source/model.dart';

import '../../../add_section/data/model/get_article_model.dart';

class SPArticleModel extends BaseModel {
  List<GetMyArticles>? article;

  SPArticleModel({this.article});

  SPArticleModel.fromJson(Map<String, dynamic> json) {
    if (json['articles'] != null) {
      article = <GetMyArticles>[];
      json['articles'].forEach((v) {
        article!.add(new GetMyArticles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.article != null) {
      data['articles'] = this.article!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
