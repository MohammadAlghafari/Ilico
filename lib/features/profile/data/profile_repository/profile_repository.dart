import 'package:charja_charity/core/repository/core_repository.dart';
import 'package:charja_charity/features/profile/data/use_case/profile_usecase.dart';

import '../../../../core/constants/end_point.dart';
import '../../../../core/data_source/remote_data_source.dart';
import '../../../../core/http/http_method.dart';
import '../../../../core/results/result.dart';
import '../../../../core/utils/cashe_helper.dart';
import '../model/get_product_model.dart';
import '../model/profile_model.dart';
import '../use_case/edit_company_service_provider.dart';
import '../use_case/edit_profile_usecase.dart';
import '../use_case/get_product_usecase.dart';
import '../use_case/social_data_usecase.dart';

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

  Future<Result<List<GetproductModel>>> getProduct({required GetProductParams params}) async {
    final result = await RemoteDataSource.request(
        withAuthentication: true,
        queryParameters: params.tojson(),
        // data: params.toJson(),
        url: urlAccordingType(params: params),
        method: HttpMethod.GET,
        responseStr: 'GetProductResponse',
        converter: (json) => GetProductResponse.fromJson(json));
    return paginatedCall(result: result);
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
}
