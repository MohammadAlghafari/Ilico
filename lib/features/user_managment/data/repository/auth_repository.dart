import 'package:charja_charity/core/http/graphQl_provider.dart';
import 'package:charja_charity/core/repository/core_repository.dart';
import 'package:charja_charity/core/utils/cashe_helper.dart';
import 'package:charja_charity/features/user_managment/data/model/resetPasswordModel.dart';
import 'package:charja_charity/features/user_managment/data/usecase/forget_password_usecase.dart';
import 'package:charja_charity/features/user_managment/data/usecase/get_category_usecase.dart';
import 'package:charja_charity/features/user_managment/data/usecase/logout_usecase.dart';
import 'package:charja_charity/features/user_managment/data/usecase/payment_usecase.dart';
import 'package:charja_charity/features/user_managment/data/usecase/resetpasswordusecase.dart';
import 'package:charja_charity/features/user_managment/data/usecase/verify_usecase.dart';

import '../../../../core/constants/end_point.dart';
import '../../../../core/data_source/remote_data_source.dart';
import '../../../../core/http/http_method.dart';
import '../../../../core/results/result.dart';
import '../../../profile/data/model/profile_model.dart';
import '../model/get_category_model.dart';
import '../model/login_model.dart';
import '../model/logout_model.dart';
import '../model/supscription_model.dart';
import '../model/user_model.dart';
import '../usecase/assign_category.dart';
import '../usecase/change_password_usecase.dart';
import '../usecase/facebook_login_ussecase.dart';
import '../usecase/login_apple_usecase.dart';
import '../usecase/login_usecse.dart';
import '../usecase/login_with_google.dart';
import '../usecase/resend_otp_usecase.dart';
import '../usecase/signup_by_apple_usecase.dart';
import '../usecase/signup_by_facecbook.dart';
import '../usecase/signup_by_google.dart';
import '../usecase/signup_usecase.dart';
import '../usecase/supscription_usecase.dart';
import '../usecase/verfiy_code_forget_password.dart';

class AuthRepository extends CoreRepository {
  Future<Result<LoginModel>> getLogin({required GetLoginParams params}) async {
    final result = await RemoteDataSource.qlRequest(
        withAuthentication: false,
        params: params.toJson(),
        query: params.query!,
        method: QlMethod.mutations,
        responseStr: 'LoginModel',
        modelKey: 'login',
        converter: (json) => LoginModel.fromJson(json));
    return call(result: result);
  }

  Future<Result<ResetPasswordModel>> changePassword({required ResetPasswordParams params}) async {
    final result = await RemoteDataSource.qlRequest(
        withAuthentication: false,
        params: params.toJson(),
        query: params.query!,
        method: QlMethod.mutations,
        responseStr: 'ResetPasswordModel',
        modelKey: '',
        converter: (json) => ResetPasswordModel.fromJson(json));
    return call(result: result);
  }

  Future<Result<UserModel>> signUp({required SignUpParams params}) async {
    final result = await RemoteDataSource.qlRequest(
      modelKey: 'signupUser',
      withAuthentication: false,
      params: params.toJson(),
      method: QlMethod.mutations,
      responseStr: "UserModel",
      converter: (json) => UserModel.fromJson(json),
      query: params.query!,
    );
    return call(result: result);
  }

  Future<Result<UserModel>> signUpByGoogle({required SignUpByGoogleParams params}) async {
    final result = await RemoteDataSource.qlRequest(
      modelKey: 'signupUserByGoogle', //todo
      withAuthentication: false,
      params: params.toJson(),
      method: QlMethod.mutations,
      withCash: false,
      responseStr: "UserModel",
      converter: (json) => UserModel.fromJson(json),
      query: params.query!,
    );
    return call(result: result);
  }

  Future<Result<UserModel>> signUpByApple({required SignUpByAppleParams params}) async {
    final result = await RemoteDataSource.qlRequest(
      modelKey: 'signupUserByApple', //todo
      withAuthentication: false,
      params: params.toJson(),
      method: QlMethod.mutations,
      withCash: false,
      responseStr: "UserModel",
      converter: (json) => UserModel.fromJson(json),
      query: params.query!,
    );
    return call(result: result);
  }

  Future<Result<UserModel>> signUpByFacebook({required SignUpByFacebookParams params}) async {
    final result = await RemoteDataSource.qlRequest(
      modelKey: 'signupUserByFacebook', //todo
      withAuthentication: false,
      params: params.toJson(),
      method: QlMethod.mutations,
      withCash: false,
      responseStr: "UserModel",
      converter: (json) => UserModel.fromJson(json),
      query: params.query!,
    );
    return call(result: result);
  }

  Future<Result<bool>> forgetPassword({required ForgetPasswordParams params}) async {
    final result = await RemoteDataSource.noModelRequest(
      data: {'email': params.email.trim()},
      withAuthentication: false,
      url: FORGET_PASSWORD_URL,
      method: HttpMethod.POST,
    );
    return noModelCall(result: result);
  }

  Future<Result<LoginModel>> getUserInfo({required GetUserInfoParams params}) async {
    final result = await RemoteDataSource.qlRequest(
        withAuthentication: false,
        params: params.toJson(),
        query: params.query!,
        method: QlMethod.mutations,
        responseStr: 'LoginModel',
        converter: (json) => LoginModel.fromJson(json),
        modelKey: 'verifyUser');

    return call(result: result);
  }

  Future<Result<LogOutModel>> LogOut({required LogOutParams params}) async {
    final result = await RemoteDataSource.qlRequest(
      withAuthentication: true,
      query: params.query!,
      method: QlMethod.mutations,
      responseStr: 'LogOutModel',
      converter: (json) => LogOutModel.fromJson(json),
      modelKey: '',
    );
    return call(result: result);
  }

  Future<Result<bool>> ResendOTP({required ResendOTPParams params}) async {
    final result = await RemoteDataSource.noModelRequest(
      withAuthentication: false,
      url: Resend_OTP_URL,
      data: params.toJson(),
      method: HttpMethod.POST,
    );
    return noModelCall(result: result);
  }

  Future<Result<LoginModel>> loginWithGoogle({required GetLoginWithGoogleParams params}) async {
    final result = await RemoteDataSource.qlRequest(
      modelKey: 'googleLogin',
      withAuthentication: false,
      params: params.toJson(),
      method: QlMethod.mutations,
      responseStr: "LoginModel",
      converter: (json) => LoginModel.fromJson(json),
      query: params.query!,
    );
    return call(result: result);
  }

  Future<Result<LoginModel>> loginWithApple({required LoginWithAppleParams params}) async {
    final result = await RemoteDataSource.qlRequest(
      modelKey: 'appleLogin',
      withAuthentication: false,
      params: params.toJson(),
      method: QlMethod.mutations,
      responseStr: "LoginModel",
      converter: (json) => LoginModel.fromJson(json),
      query: params.query!,
    );
    return call(result: result);
  }

  Future<Result<LoginModel>> loginWithFacebook({required GetLoginWithFacebookParams params}) async {
    final result = await RemoteDataSource.qlRequest(
      modelKey: 'facebookLogin',
      withAuthentication: false,
      params: params.toJson(),
      method: QlMethod.mutations,
      responseStr: "LoginModel",
      converter: (json) => LoginModel.fromJson(json),
      query: params.query!,
    );
    return call(result: result);
  }

  Future<Result<List<Activities>>> getCategories({required GetCategoriesParams params}) async {
    final result = await RemoteDataSource.request(
        withAuthentication: true,
        url: GET_CATEGORIES_URL,
        queryParameters: params.tojson(),
        method: HttpMethod.GET,
        responseStr: 'CategoriesResponse',
        converter: (json) => CategoriesResponse.fromJson(json));
    return paginatedCall(result: result);
  }

  Future<Result<UserInfo>> assignCategory({required AssignCategoryParams params}) async {
    final result = await RemoteDataSource.request(
        withAuthentication: true,
        url: url,
        data: params.toJson(),
        method: HttpMethod.PUT,
        responseStr: 'ProfileResponse',
        converter: (json) => ProfileResponse.fromJson(json));
    return call(result: result);
  }

  Future<Result<List<Supscription>>> getPackegs({required SupscriptionParams params}) async {
    final result = await RemoteDataSource.request(
        withAuthentication: false,
        queryParameters: params.tojson(),
        // data: params.toJson(),
        url: Get_PACKAEG,
        method: HttpMethod.GET,
        responseStr: 'SupscriptionResponse',
        converter: (json) => SupscriptionResponse.fromJson(json));
    return paginatedCall(result: result);
  }

  get url {
    String? role = CashHelper.getRole();
    if (role == 'Customer') {
      return ASSIGN_CATEGORIES_CUSTOMER;
    } else if (role == 'Influencer') {
      return ASSIGN_CATEGOIES_INFLUNCER;
    } else {
      return ASSIGN_CATEGORY_SERVICE;
    }
  }

  Future<Result<bool>> ForgetPasswordOtp({required ForgetPasswordOtpParams params}) async {
    final result = await RemoteDataSource.noModelRequest(
      withAuthentication: false,
      url: Verfiy_vode_forget_password,
      data: params.toJson(),
      method: HttpMethod.POST,
    );
    return noModelCall(result: result);
  }

  Future<Result<UserModel>> addPayment({required PaymentParams params}) async {
    final result = await RemoteDataSource.request(
        withAuthentication: true,
        url: ADD_PAYMENT,
        data: params.toJson(),
        method: HttpMethod.POST,
        responseStr: 'UserInfoResponse',
        converter: (json) => UserInfoResponse.fromJson(json));

    return call(result: result);
  }

  Future<Result<bool>> ChangePassword({required ChangePasswordParams params}) async {
    final result = await RemoteDataSource.noModelRequest(
      withAuthentication: false,
      url: Change_password,
      data: params.toJson(),
      method: HttpMethod.POST,
    );
    return noModelCall(result: result);
  }
}
