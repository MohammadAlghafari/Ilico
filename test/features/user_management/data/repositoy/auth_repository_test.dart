import 'package:charja_charity/core/boilerplate/pagination/models/get_list_request.dart';
import 'package:charja_charity/core/errors/http_error.dart';
import 'package:charja_charity/core/results/result.dart';
import 'package:charja_charity/features/user_managment/data/model/login_model.dart';
import 'package:charja_charity/features/user_managment/data/model/supscription_model.dart';
import 'package:charja_charity/features/user_managment/data/model/user_model.dart';
import 'package:charja_charity/features/user_managment/data/repository/auth_repository.dart';
import 'package:charja_charity/features/user_managment/data/usecase/forget_password_usecase.dart';
import 'package:charja_charity/features/user_managment/data/usecase/login_usecse.dart';
import 'package:charja_charity/features/user_managment/data/usecase/logout_usecase.dart';
import 'package:charja_charity/features/user_managment/data/usecase/resend_otp_usecase.dart';
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

  ForgetPasswordParams forgetPasswordParams = ForgetPasswordParams(email: 'angham@yopmail.com');

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
    when(authRepository!.LogOut(params: logOutParams)).thenAnswer((_) async => Result<bool>(
          data: true,
        ));
    final result = await authRepository!.LogOut(params: logOutParams);

    expect(result.hasDataOnly, true);
    expect(result.data, true);
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
}
