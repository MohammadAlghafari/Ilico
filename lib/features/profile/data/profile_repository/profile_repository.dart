import 'package:charja_charity/core/repository/core_repository.dart';
import 'package:charja_charity/features/profile/data/model/SPArticleModel.dart';
import 'package:charja_charity/features/profile/data/model/SPEventModel.dart';
import 'package:charja_charity/features/profile/data/model/SPProductsModel.dart';
import 'package:charja_charity/features/profile/data/model/SPServiceModel.dart';
import 'package:charja_charity/features/profile/data/model/SpMediaModel.dart';
import 'package:charja_charity/features/profile/data/model/delete_account_model.dart';
import 'package:charja_charity/features/profile/data/model/influncer_general_information_model.dart';
import 'package:charja_charity/features/profile/data/model/sp_general_information_model.dart';
import 'package:charja_charity/features/profile/data/use_case/delete_account_usecase.dart';
import 'package:charja_charity/features/profile/data/use_case/influncer_get_article_usecase.dart';
import 'package:charja_charity/features/profile/data/use_case/profile_usecase.dart';
import 'package:charja_charity/features/profile/data/use_case/sp_general_information_usecase.dart';
import 'package:charja_charity/features/profile/data/use_case/sp_get_article_usecase.dart';
import 'package:charja_charity/features/profile/data/use_case/sp_get_gallery_usecase.dart';

import '../../../../core/constants/end_point.dart';
import '../../../../core/data_source/remote_data_source.dart';
import '../../../../core/http/graphQl_provider.dart';
import '../../../../core/http/http_method.dart';
import '../../../../core/results/result.dart';
import '../../../../core/utils/cashe_helper.dart';
import '../../../add_section/data/usecase/get_product_usecase.dart';
import '../../../search/data/model/search_model.dart';
import '../model/get_my_favorite_model.dart';
import '../model/profile_model.dart';
import '../model/toggle_favorite_result.dart';
import '../use_case/edit_company_service_provider.dart';
import '../use_case/edit_profile_usecase.dart';
import '../use_case/get_my_favorite_usecase.dart';
import '../use_case/influncer_general_information_usecase.dart';
import '../use_case/influncer_get_gallery_usecase.dart';
import '../use_case/social_data_usecase.dart';
import '../use_case/sp_get_event_usecase.dart';
import '../use_case/sp_get_products_usecase.dart';
import '../use_case/sp_get_services_usecase.dart';
import '../use_case/toggel_isAvaliable_usecase.dart';
import '../use_case/toogel_favorite_usecase.dart';

class ProfileRepository extends CoreRepository {
  Future<Result<UserInfo>> getProfile({required ProfileParams params}) async {
    final result = await RemoteDataSource.request(
        withAuthentication: true,
        url: getUrl(),
        method: HttpMethod.GET,
        responseStr: 'ProfileResponse',
        converter: (json) => ProfileResponse.fromJson(json));
    // final result = await RemoteDataSource.qlRequest<Products, ProductModel>(
    //     responseStr: 'ProductModel',
    //     converter: (json) => ProductModel.fromJson(json),
    //     method: QlMethod.query,
    //     query: params.query!);
    return call(result: result);
  }

  getUrl() {
    if (CashHelper.getRole() == 'Customer') {
      return PROFILR_CUSTOMR_URL;
    } else if (CashHelper.getRole() == 'Influencer') {
      return PROFILE_INFL_URL;
    } else if (CashHelper.getRole() == 'ServiceProvider') {
      return PROFILE_SP_URL;
    }
  }

  Future<Result<UserInfo>> editProfile({required EditProfileParams params}) async {
    final result = await RemoteDataSource.request(
        withAuthentication: true,
        data: params.toJson(),
        url: getUrlEditProfile(),
        method: HttpMethod.PUT,
        responseStr: 'ProfileResponse',
        converter: (json) => ProfileResponse.fromJson(json));
    return call(result: result);
  }

  getUrlEditProfile() {
    if (CashHelper.getRole() == 'Customer') {
      return EDIT_PROFILE_CUSTOMER_URL;
    } else if (CashHelper.getRole() == 'Influencer') {
      return EDIT_PROFILE_INFL_URL;
    } else if (CashHelper.getRole() == 'ServiceProvider') {
      return EDIT_PROFILE_SP_URL;
    }
  }

  Future<Result<Company>> editCompany({required EditCompanyProfileParams params}) async {
    final result = await RemoteDataSource.request(
        data: params.toJson(),
        withAuthentication: true,
        url: EDIT_COMPANY,
        method: HttpMethod.PUT,
        responseStr: 'CompanyResponse',
        converter: (json) => CompanyResponse.fromJson(json));
    return call(result: result);
  }

  Future<Result<UserInfo>> update_social_media_data({required SocialDataParams params}) async {
    final result = await RemoteDataSource.request(
        withAuthentication: true,
        url: update_influncer_social_media,
        data: params.toJson(),
        method: HttpMethod.PUT,
        responseStr: 'ProfileResponse',
        converter: (json) => ProfileResponse.fromJson(json));
    return call(result: result);
  }

  Future<Result<DeleteAccountModel>> deleteAccount({required DeleteAccountParams params}) async {
    final result = await RemoteDataSource.qlRequest(
      withAuthentication: true,
      query: params.query!,
      method: QlMethod.mutations,
      params: params.toJson(),
      responseStr: 'DeleteAccountModel',
      converter: (json) => DeleteAccountModel.fromJson(json),
      modelKey: '',
    );
    return call(result: result);
  }

  Future<Result<SPGeneralInformationModel>> get_ServiceProviderByID(
      {required SPGeneralInformationParams params}) async {
    final result = await RemoteDataSource.qlRequest(
        withAuthentication: false,
        withCash: false,
        method: QlMethod.query,
        params: params.toJson(),
        responseStr: 'SPGeneralInformationModel',
        converter: (json) => SPGeneralInformationModel.fromJson(json),
        query: params.query,
        modelKey: getModelKeyForServiceProvider());
    return call(result: result);
  }

  Future<Result<SPService>> getServicesById({required SPGetServicesParams params}) async {
    final result = await RemoteDataSource.qlRequest(
        withAuthentication: false,
        method: QlMethod.query,
        params: params.toJson(),
        withCash: false,
        responseStr: 'SPService',
        converter: (json) => SPService.fromJson(json),
        query: params.query,
        modelKey: getModelKeyForServiceProvider());
    return call(result: result);
  }

  Future<Result<SPProduct>> getProductsById({required SPGetProductsParams params}) async {
    final result = await RemoteDataSource.qlRequest(
        withAuthentication: false,
        method: QlMethod.query,
        params: params.toJson(),
        withCash: false,
        responseStr: 'SPProduct',
        converter: (json) => SPProduct.fromJson(json),
        query: params.query,
        modelKey: getModelKeyForServiceProvider());
    return call(result: result);
  }

  Future<Result<SPEvent>> getEventById({required SPGetEventParams params}) async {
    final result = await RemoteDataSource.qlRequest(
        withAuthentication: false,
        withCash: false,
        method: QlMethod.query,
        params: params.toJson(),
        responseStr: 'SPEvent',
        converter: (json) => SPEvent.fromJson(json),
        query: params.query,
        modelKey: getModelKeyForServiceProvider());
    return call(result: result);
  }

  Future<Result<SPGallery>> getSPGalleryById({required SPGetGalleryParams params}) async {
    final result = await RemoteDataSource.qlRequest(
        withAuthentication: false,
        withCash: false,
        method: QlMethod.query,
        params: params.toJson(),
        responseStr: 'SPGallery',
        converter: (json) => SPGallery.fromJson(json),
        query: params.query,
        modelKey: getModelKeyForServiceProvider());
    return call(result: result);
  }

  Future<Result<SPGallery>> getInfluncerGalleryById({required InfluncerGetGalleryParams params}) async {
    final result = await RemoteDataSource.qlRequest(
        withAuthentication: false,
        withCash: false,
        method: QlMethod.query,
        params: params.toJson(),
        responseStr: 'SPGallery',
        converter: (json) => SPGallery.fromJson(json),
        query: params.query,
        modelKey: getModelKeyForInfluncer());
    return call(result: result);
  }

  Future<Result<SPArticleModel>> getArticleById({required SPGetArticleParams params}) async {
    final result = await RemoteDataSource.qlRequest(
        withAuthentication: false,
        withCash: false,
        method: QlMethod.query,
        params: params.toJson(),
        responseStr: 'SPArticleModel',
        converter: (json) => SPArticleModel.fromJson(json),
        query: params.query,
        modelKey: getModelKeyForServiceProvider());
    return call(result: result);
  }

  Future<Result<SPArticleModel>> getInfluncerArticleByID({required InfluncerGetArticleParams params}) async {
    final result = await RemoteDataSource.qlRequest(
        withAuthentication: false,
        withCash: false,
        method: QlMethod.query,
        params: params.toJson(),
        responseStr: 'SPArticleModel',
        converter: (json) => SPArticleModel.fromJson(json),
        query: params.query,
        modelKey: getModelKeyForInfluncer());
    return call(result: result);
  }

  String urlAccordingType({required GetProductParams params}) {
    if (params.type == "getProduct") {
      return Get_PRODUCT;
    } else if (params.type == "getService") {
      return Get_SERVICE;
    } else if (params.type == "getEvent") {
      return ""; // todo url get event
    }
    return "";
  }

  String getModelKeyForServiceProvider() {
    if (CashHelper.authorized) {
      return "serviceProviderForUser";
    } else {
      return "serviceProviderForGuest";
    }
  }

  Future<Result<ToggleFavoriteResult>> toggleFavorite({required ToggleFavoriteParams params}) async {
    final result = await RemoteDataSource.qlRequest(
        withAuthentication: false,
        query: params.query!,
        params: params.toJson(),
        method: QlMethod.mutations,
        responseStr: 'ToggleFavoriteResult',
        converter: (json) => ToggleFavoriteResult.fromJson(json),
        modelKey: 'toggleFavorite');
    return call(result: result);
  }

  Future<Result<SearchOfServiceProvider>> toggleIsAvailable({required ToggleIsAvaliableParams params}) async {
    final result = await RemoteDataSource.qlRequest(
        withAuthentication: true,
        query: params.query!,
        method: QlMethod.mutations,
        responseStr: 'SearchOfServiceProvider',
        converter: (json) => SearchOfServiceProvider.fromJson(json),
        modelKey: 'toggleIsAvialable');
    return call(result: result);
  }

  Future<Result<GetMyFavoriteListModel>> getMyFavorite({required GetMyFavoriteParams params}) async {
    final result = await RemoteDataSource.qlRequest(
        query: params.query!,
        modelKey: '',
        params: params.toJson(),
        withAuthentication: false,
        withCash: false,
        method: QlMethod.query,
        responseStr: 'GetMyFavoriteListModel',
        converter: (json) => GetMyFavoriteListModel.fromJson(json));
    return call(result: result);
  }

  Future<Result<InfluncerGeneralInformationModel>> get_InfluncerById(
      {required InfluncerGeneralInformationParams params}) async {
    final result = await RemoteDataSource.qlRequest(
        withAuthentication: true,
        withCash: false,
        method: QlMethod.query,
        params: params.toJson(),
        responseStr: 'InfluncerGeneralInformationModel',
        converter: (json) => InfluncerGeneralInformationModel.fromJson(json),
        query: params.query,
        modelKey: getModelKeyForInfluncer());
    return call(result: result);
  }

  String getModelKeyForInfluncer() {
    if (CashHelper.authorized) {
      return "influencerForUser";
    } else {
      return "influencerForGuest";
    }
  }
}
