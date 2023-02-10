import 'package:charja_charity/core/boilerplate/pagination/models/get_list_request.dart';
import 'package:charja_charity/core/errors/http_error.dart';
import 'package:charja_charity/core/results/result.dart';
import 'package:charja_charity/features/user_managment/data/model/login_model.dart';
import 'package:charja_charity/features/user_managment/data/model/logout_model.dart';
import 'package:charja_charity/features/user_managment/data/model/resetPasswordModel.dart';
import 'package:charja_charity/features/user_managment/data/model/supscription_model.dart';
import 'package:charja_charity/features/user_managment/data/model/user_model.dart';
import 'package:charja_charity/features/user_managment/data/repository/auth_repository.dart';
import 'package:charja_charity/features/user_managment/data/usecase/facebook_login_ussecase.dart';
import 'package:charja_charity/features/user_managment/data/usecase/forget_password_usecase.dart';
import 'package:charja_charity/features/user_managment/data/usecase/login_apple_usecase.dart';
import 'package:charja_charity/features/user_managment/data/usecase/login_usecse.dart';
import 'package:charja_charity/features/user_managment/data/usecase/login_with_google.dart';
import 'package:charja_charity/features/user_managment/data/usecase/logout_usecase.dart';
import 'package:charja_charity/features/user_managment/data/usecase/resend_otp_usecase.dart';
import 'package:charja_charity/features/user_managment/data/usecase/resetpasswordusecase.dart';
import 'package:charja_charity/features/user_managment/data/usecase/signup_by_apple_usecase.dart';
import 'package:charja_charity/features/user_managment/data/usecase/signup_by_facecbook.dart';
import 'package:charja_charity/features/user_managment/data/usecase/signup_by_google.dart';
import 'package:charja_charity/features/user_managment/data/usecase/signup_usecase.dart';
import 'package:charja_charity/features/user_managment/data/usecase/supscription_usecase.dart';
import 'package:charja_charity/features/user_managment/data/usecase/verify_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_repository_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  AuthRepository? authRepository;
  setUp(() {
    authRepository = MockAuthRepository();
  });

  GetListRequest request = GetListRequest(limit: 20, order: "asc", page: 1);
  SupscriptionParams supscriptionParams = SupscriptionParams(request: request);
  Supscription supscription = Supscription(
      description: "test", price: 120, id: "1230", title: "title", isSelected: false, duration: 12, activityCount: 2);
  List<Supscription> supscriptionList = [supscription, supscription];
  SignUpParams params = SignUpParams(
      roleKey: "CUSTOMER",
      firstName: "lekaa",
      lastName: "jjj",
      phone: '0938362440',
      email: "leka.alawad@gmail.com",
      password: "123456789Qa@",
      isCustomer: false);
  LogOutModel logOutModel = LogOutModel(message: "test");

  ForgetPasswordParams forgetPasswordParams = ForgetPasswordParams(email: 'angham@yopmail.com');
  ResetPasswordModel resetPasswordModel = ResetPasswordModel(message: "test");
  ResetPasswordParams resetPasswordParams =
      ResetPasswordParams(oldPassword: "12312344@As", newPassword: "123131232@As", confirmNewPassword: "123131232@As");

  LoginModel loginModel = LoginModel(
      refreshTokenExpirationDate: 'fg',
      accessToken: 'en',
      accessTokenExpirationDate: 'lll',
      refreshToken: 'lllllllllllllllll');
  GetLoginParams loginParams = GetLoginParams(email: 'lal', password: 'llkkk');

  UserModel userModel = UserModel(id: "1", name: "test", email: "ibrahem@gmail.com", gender: "Male");
  GetUserInfoParams getUserInfoParams = GetUserInfoParams(phoneNumber: "ibrahem@gmail.com", otpCode: 12345);

  LogOutParams logOutParams = LogOutParams();

  ResendOTPParams resendOTPParams = ResendOTPParams(email: "ibrahim@gmail.com");

  GetLoginWithFacebookParams getLoginWithFacebookParams = GetLoginWithFacebookParams(
    email: 'ANGHAM@yopmail.com',
    facebookProfileId: "id",
  );

  GetLoginWithGoogleParams getLoginWithGoogleParams = GetLoginWithGoogleParams(
    email: 'ANGHAM@yopmail.com',
    googleProfileId: "id",
  );

  SignUpByFacebookParams signUpByFacebookParams = SignUpByFacebookParams(
      roleKey: "CUSTOMER",
      firstName: "lekaa",
      lastName: "kmlk",
      phone: '0938362440',
      email: "leka.alawad@gmail.com",
      facebookProfileId: "id",
      isCustomer: false);
  SignUpByGoogleParams signUpByGoogleParams = SignUpByGoogleParams(
      roleKey: "CUSTOMER",
      firstName: "lekaa",
      lastName: "kmlk",
      phone: '0938362440',
      email: "leka.alawad@gmail.com",
      googleProfileId: "id",
      isCustomer: false);

  SignUpByAppleParams signUpByAppleParams = SignUpByAppleParams(
      roleKey: "CUSTOMER",
      firstName: "lekaa",
      lastName: "kmlk",
      phone: '0938362440',
      email: "leka.alawad@gmail.com",
      appleProfileId: "id",
      isCustomer: false);

  LoginWithAppleParams loginWithAppleParams = LoginWithAppleParams(
    email: 'ANGHAM@yopmail.com',
    appleProfileId: "id",
  );

  HttpError error = const HttpError(message: ['Http error']);

  test('Success sign up', () async {
    when(authRepository!.signUp(params: params)).thenAnswer((_) async => RemoteResult(
          data: userModel,
        ));
    final result = await authRepository!.signUp(params: params);

    expect(result.hasDataOnly, true);
    expect(result.data, userModel);
    verify(authRepository!.signUp(params: params));
  });
  test('fail sign up', () async {
    when(authRepository!.signUp(params: params)).thenAnswer((_) async => RemoteResult(error: error));

    final result = await authRepository!.signUp(params: params);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(authRepository!.signUp(params: params));
  });

  test('Success forget password', () async {
    when(authRepository!.forgetPassword(params: forgetPasswordParams)).thenAnswer((_) async => Result<bool>(
          data: true,
        ));
    final result = await authRepository!.forgetPassword(params: forgetPasswordParams);

    expect(result.hasDataOnly, true);
    expect(result.data, true);
    verify(authRepository!.forgetPassword(params: forgetPasswordParams));
  });
  test('fail forget password', () async {
    when(authRepository!.forgetPassword(params: forgetPasswordParams))
        .thenAnswer((_) async => RemoteResult(error: error));

    final result = await authRepository!.forgetPassword(params: forgetPasswordParams);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(authRepository!.forgetPassword(params: forgetPasswordParams));
  });

  test('Success logIn', () async {
    when(authRepository!.getLogin(params: loginParams)).thenAnswer((_) async => RemoteResult(
          data: loginModel,
        ));
    final result = await authRepository!.getLogin(params: loginParams);

    expect(result.hasDataOnly, true);
    expect(result.data, loginModel);
    verify(authRepository?.getLogin(params: loginParams));
  });
  test('fail login', () async {
    when(authRepository!.getLogin(params: loginParams)).thenAnswer((_) async => RemoteResult(error: error));

    final result = await authRepository!.getLogin(params: loginParams);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(authRepository!.getLogin(params: loginParams));
  });

  test('Success Verify', () async {
    when(authRepository!.getUserInfo(params: getUserInfoParams)).thenAnswer((_) async => RemoteResult(
          data: loginModel,
        ));
    final result = await authRepository!.getUserInfo(params: getUserInfoParams);

    expect(result.hasDataOnly, true);
    expect(result.data, loginModel);
    verify(authRepository?.getUserInfo(params: getUserInfoParams));
  });
  test('fail Verify', () async {
    when(authRepository!.getUserInfo(params: getUserInfoParams)).thenAnswer((_) async => RemoteResult(error: error));

    final result = await authRepository!.getUserInfo(params: getUserInfoParams);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(authRepository!.getUserInfo(params: getUserInfoParams));
  });

  test('Success logout', () async {
    when(authRepository!.LogOut(params: logOutParams)).thenAnswer((_) async => Result<LogOutModel>(
          data: logOutModel,
        ));
    final result = await authRepository!.LogOut(params: logOutParams);

    expect(result.hasDataOnly, true);
    expect(result.data, logOutModel);
    verify(authRepository!.LogOut(params: logOutParams));
  });
  test('fail logout', () async {
    when(authRepository!.LogOut(params: logOutParams)).thenAnswer((_) async => RemoteResult(error: error));

    final result = await authRepository!.LogOut(params: logOutParams);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(authRepository!.LogOut(params: logOutParams));
  });

  test('Success Resend OTP Code', () async {
    when(authRepository!.ResendOTP(params: resendOTPParams)).thenAnswer((_) async => Result<bool>(
          data: true,
        ));
    final result = await authRepository!.ResendOTP(params: resendOTPParams);

    expect(result.hasDataOnly, true);
    expect(result.data, true);
    verify(authRepository!.ResendOTP(params: resendOTPParams));
  });
  test('fail Resend OTP Code', () async {
    when(authRepository!.ResendOTP(params: resendOTPParams)).thenAnswer((_) async => RemoteResult(error: error));

    final result = await authRepository!.ResendOTP(params: resendOTPParams);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(authRepository!.ResendOTP(params: resendOTPParams));
  });

  test('Success get Supscription', () async {
    when(authRepository!.getPackegs(params: supscriptionParams)).thenAnswer((_) async => PaginatedResult(
          data: supscriptionList,
        ));
    final result = await authRepository!.getPackegs(params: supscriptionParams);

    expect(result.hasDataOnly, true);
    expect(result.data, supscriptionList);
    verify(authRepository!.getPackegs(params: supscriptionParams));
  });
  test('fail get Supscription', () async {
    when(authRepository!.getPackegs(params: supscriptionParams)).thenAnswer((_) async => PaginatedResult(error: error));

    final result = await authRepository!.getPackegs(params: supscriptionParams);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(authRepository!.getPackegs(params: supscriptionParams));
  });

  test('Success change password', () async {
    when(authRepository!.changePassword(params: resetPasswordParams))
        .thenAnswer((_) async => Result<ResetPasswordModel>(
              data: resetPasswordModel,
            ));
    final result = await authRepository!.changePassword(params: resetPasswordParams);

    expect(result.hasDataOnly, true);
    expect(result.data, resetPasswordModel);
    verify(authRepository!.changePassword(params: resetPasswordParams));
  });
  test('fail change password', () async {
    when(authRepository!.changePassword(params: resetPasswordParams))
        .thenAnswer((_) async => RemoteResult(error: error));

    final result = await authRepository!.changePassword(params: resetPasswordParams);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(authRepository!.changePassword(params: resetPasswordParams));
  });

  test('Success logIn with google', () async {
    when(authRepository!.loginWithGoogle(params: getLoginWithGoogleParams)).thenAnswer((_) async => RemoteResult(
          data: loginModel,
        ));
    final result = await authRepository!.loginWithGoogle(params: getLoginWithGoogleParams);

    expect(result.hasDataOnly, true);
    expect(result.data, loginModel);
    verify(authRepository?.loginWithGoogle(params: getLoginWithGoogleParams));
  });
  test('fail login with google', () async {
    when(authRepository!.loginWithGoogle(params: getLoginWithGoogleParams))
        .thenAnswer((_) async => RemoteResult(error: error));

    final result = await authRepository!.loginWithGoogle(params: getLoginWithGoogleParams);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(authRepository!.loginWithGoogle(params: getLoginWithGoogleParams));
  });

  test('Success logIn with facebook', () async {
    when(authRepository!.loginWithFacebook(params: getLoginWithFacebookParams)).thenAnswer((_) async => RemoteResult(
          data: loginModel,
        ));
    final result = await authRepository!.loginWithFacebook(params: getLoginWithFacebookParams);

    expect(result.hasDataOnly, true);
    expect(result.data, loginModel);
    verify(authRepository?.loginWithFacebook(params: getLoginWithFacebookParams));
  });
  test('fail login with facebook', () async {
    when(authRepository!.loginWithFacebook(params: getLoginWithFacebookParams))
        .thenAnswer((_) async => RemoteResult(error: error));

    final result = await authRepository!.loginWithFacebook(params: getLoginWithFacebookParams);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(authRepository!.loginWithFacebook(params: getLoginWithFacebookParams));
  });

  test('Success logIn with Apple', () async {
    when(authRepository!.loginWithApple(params: loginWithAppleParams)).thenAnswer((_) async => RemoteResult(
          data: loginModel,
        ));
    final result = await authRepository!.loginWithApple(params: loginWithAppleParams);

    expect(result.hasDataOnly, true);
    expect(result.data, loginModel);
    verify(authRepository?.loginWithApple(params: loginWithAppleParams));
  });
  test('fail login with Apple', () async {
    when(authRepository!.loginWithApple(params: loginWithAppleParams))
        .thenAnswer((_) async => RemoteResult(error: error));

    final result = await authRepository!.loginWithApple(params: loginWithAppleParams);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(authRepository!.loginWithApple(params: loginWithAppleParams));
  });

  test('Success singup with google', () async {
    when(authRepository!.signUpByGoogle(params: signUpByGoogleParams)).thenAnswer((_) async => RemoteResult(
          data: userModel,
        ));
    final result = await authRepository!.signUpByGoogle(params: signUpByGoogleParams);

    expect(result.hasDataOnly, true);
    expect(result.data, userModel);
    verify(authRepository?.signUpByGoogle(params: signUpByGoogleParams));
  });
  test('fail singup with google', () async {
    when(authRepository!.signUpByGoogle(params: signUpByGoogleParams))
        .thenAnswer((_) async => RemoteResult(error: error));

    final result = await authRepository!.signUpByGoogle(params: signUpByGoogleParams);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(authRepository!.signUpByGoogle(params: signUpByGoogleParams));
  });

  test('Success singup with facebook', () async {
    when(authRepository!.signUpByFacebook(params: signUpByFacebookParams)).thenAnswer((_) async => RemoteResult(
          data: userModel,
        ));
    final result = await authRepository!.signUpByFacebook(params: signUpByFacebookParams);

    expect(result.hasDataOnly, true);
    expect(result.data, userModel);
    verify(authRepository?.signUpByFacebook(params: signUpByFacebookParams));
  });
  test('fail singup with facebook', () async {
    when(authRepository!.signUpByFacebook(params: signUpByFacebookParams))
        .thenAnswer((_) async => RemoteResult(error: error));

    final result = await authRepository!.signUpByFacebook(params: signUpByFacebookParams);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(authRepository!.signUpByFacebook(params: signUpByFacebookParams));
  });

  test('Success singup with Apple', () async {
    when(authRepository!.signUpByApple(params: signUpByAppleParams)).thenAnswer((_) async => RemoteResult(
          data: userModel,
        ));
    final result = await authRepository!.signUpByApple(params: signUpByAppleParams);

    expect(result.hasDataOnly, true);
    expect(result.data, userModel);
    verify(authRepository?.signUpByApple(params: signUpByAppleParams));
  });
  test('fail singup with Apple', () async {
    when(authRepository!.signUpByApple(params: signUpByAppleParams))
        .thenAnswer((_) async => RemoteResult(error: error));

    final result = await authRepository!.signUpByApple(params: signUpByAppleParams);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(authRepository!.signUpByApple(params: signUpByAppleParams));
  });
}
