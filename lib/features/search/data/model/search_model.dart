import 'package:charja_charity/core/data_source/model.dart';
import 'package:charja_charity/features/add_section/data/model/get_article_model.dart';
import 'package:charja_charity/features/add_section/data/model/new_service.dart';

import '../../../add_section/data/model/addEvent_model.dart';
import '../../../profile/data/model/profile_model.dart';

class SearchModel extends BaseModel {
  List<SearchOfServiceProvider>? data;

  SearchModel({this.data});

  SearchModel.fromJson(Map<String, dynamic> json) {
    if (json['searchOfServiceProviderForUser'] != null) {
      data = <SearchOfServiceProvider>[];
      json['searchOfServiceProviderForUser'].forEach((v) {
        data!.add(SearchOfServiceProvider.fromJson(v));
      });
    } else {
      if (json['searchOfServiceProviderForGuest'] != null) {
        data = <SearchOfServiceProvider>[];
        json['searchOfServiceProviderForGuest'].forEach((v) {
          data!.add(SearchOfServiceProvider.fromJson(v));
        });
      }
    }
  }
}

class SearchOfServiceProvider extends BaseModel {
  late bool isSelected;
  Address? address;
  List<AddEventModel>? events;
  GetMyArticles? myArticle;
  GeneralInformation? generalInformation;
  String? id;
  bool? isAvailable;
  bool? isEventProgress;
  String? userType;
  String? photoUrl;
  List<AddService>? products;
  List<AddService>? services;
  Company? companyModel;
  bool? isFav;

  SearchOfServiceProvider(
      {this.address,
      required this.isSelected,
      this.events,
      this.userType,
      this.generalInformation,
      this.id,
      this.isAvailable,
      this.isFav,
      this.myArticle,
      this.photoUrl,
      this.products,
      this.services,
      this.companyModel,
      this.isEventProgress});

  SearchOfServiceProvider.fromJson(Map<String, dynamic> json) {
    companyModel = json['company'] != null ? Company.fromJson(json['company']) : null;
    address = json['address'] != null ? new Address.fromJson(json['address']) : null;
    myArticle:
    json['articles'] != null ? GetMyArticles.fromJson(json["articles"]) : null;
    isFav = json['isFavorite'] ?? false;
    address = json['address'] != null ? Address.fromJson(json['address']) : null;
    userType = json['userType'];
    isEventProgress = json['isEventProgress'];

    if (json['events'] != null) {
      events = <AddEventModel>[];
      json['events'].forEach((v) {
        events!.add(AddEventModel.fromJson(v));
      });
    }
    isSelected = false;
    generalInformation =
        json['generalInformation'] != null ? GeneralInformation.fromJson(json['generalInformation']) : null;
    id = json['id'];
    isAvailable = json['isAvailable'] ?? false;
    photoUrl = json['photoUrl'];
    if (json['products'] != null) {
      products = <AddService>[];
      json['products'].forEach((v) {
        products!.add(AddService.fromJson(v));
      });
    }
    if (json['services'] != null) {
      services = <AddService>[];
      json['services'].forEach((v) {
        services!.add(AddService.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (address != null) {
      data['address'] = address!.toJson();
    }

    if (generalInformation != null) {
      data['generalInformation'] = generalInformation!.toJson();
    }
    data['id'] = id;
    data['isAvailable'] = isAvailable;
    data['photoUrl'] = photoUrl;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    if (services != null) {
      data['services'] = services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Address {
  String? address;
  String? country;
  String? state;
  String? sTypename;

  Address({this.address, this.country, this.state, this.sTypename});

  Address.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    country = json['country'];
    state = json['state'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['country'] = country;
    data['state'] = state;
    data['__typename'] = sTypename;
    return data;
  }
}
//
// class GeneralInformation {
//   double? distance;
//   double? latitude;
//   double? longitude;
//   String? fullName;
//
//   GeneralInformation({this.distance, this.latitude, this.longitude, this.fullName});
//
//   GeneralInformation.fromJson(Map<String, dynamic> json) {
//     distance = (json["distance"] != null ? double.parse(json['distance'].toString()) : null);
//     latitude = (json["latitude"] != null ? double.parse(json['latitude'].toString()) : null);
//     longitude = (json["longitude"] != null ? double.parse(json['longitude'].toString()) : null);
//     fullName = json['fullName'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['distance'] = distance;
//     data['latitude'] = latitude;
//     data['longitude'] = longitude;
//     data['fullName'] = fullName;
//     return data;
//   }
// }
//
// class Products {
//   String? description;
//   String? id;
//   List<String>? images;
//   bool? isActive;
//   String? name;
//   double? price;
//   Category? category;
//
//   Products({this.description, this.id, this.images, this.isActive, this.name, this.price, this.category});
//
//   Products.fromJson(Map<String, dynamic> json) {
//     description = json['description'];
//     id = json['id'];
//     images = (json['images'] != null ? json['images'].cast<String>() : null);
//     isActive = json['isActive'];
//     name = json['name'];
//     price = (json["price"] != null ? double.parse(json['price'].toString()) : null);
//     //category = json['category'] != null ? Category.fromJson(json['category']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['description'] = description;
//     data['id'] = id;
//     data['images'] = images;
//     data['isActive'] = isActive;
//     data['name'] = name;
//     data['price'] = price;
//     if (category != null) {
//       data['category'] = category!.toJson();
//     }
//     return data;
//   }
// }
//
// class Category {
//   String? description;
//   String? id;
//   bool? isActive;
//   String? name;
//
//   Category({this.description, this.id, this.isActive, this.name});
//
//   Category.fromJson(Map<String, dynamic> json) {
//     description = json['description'];
//     id = json['id'];
//     isActive = json['isActive'];
//     name = json['name'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['description'] = description;
//     data['id'] = id;
//     data['isActive'] = isActive;
//     data['name'] = name;
//     return data;
//   }
// }
//
// class Services {
//   String? createdAt;
//   String? description;
//   String? id;
//   List<String>? images;
//   bool? isActive;
//   String? name;
//   double? price;
//   Category? category;
//
//   Services(
//       {this.createdAt, this.description, this.id, this.images, this.isActive, this.name, this.price, this.category});
//
//   Services.fromJson(Map<String, dynamic> json) {
//     createdAt = json['createdAt'];
//     description = json['description'];
//     id = json['id'];
//     print(json['images']);
//     images = (json['images'] != null ? json['images'].cast<String>() : null);
//     isActive = json['isActive'];
//     name = json['name'];
//     price = double.parse(json['price'].toString());
//     category = json['category'] != null ? Category.fromJson(json['category']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['createdAt'] = createdAt;
//     data['description'] = description;
//     data['id'] = id;
//     data['images'] = images;
//     data['isActive'] = isActive;
//     data['name'] = name;
//     data['price'] = price;
//     if (category != null) {
//       data['category'] = category!.toJson();
//     }
//     return data;
//   }
// }
