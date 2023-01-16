// Mocks generated by Mockito 5.3.2 from annotations
// in charja_charity/test/features/user_management/data/usecase/change_password_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:charja_charity/core/data_source/model.dart' as _i22;
import 'package:charja_charity/core/errors/base_error.dart' as _i24;
import 'package:charja_charity/core/results/result.dart' as _i2;
import 'package:charja_charity/features/profile/data/model/profile_model.dart'
    as _i14;
import 'package:charja_charity/features/user_managment/data/model/login_model.dart'
    as _i5;
import 'package:charja_charity/features/user_managment/data/model/supscription_model.dart'
    as _i17;
import 'package:charja_charity/features/user_managment/data/model/user_model.dart'
    as _i7;
import 'package:charja_charity/features/user_managment/data/repository/auth_repository.dart'
    as _i3;
import 'package:charja_charity/features/user_managment/data/usecase/assign_category.dart'
    as _i16;
import 'package:charja_charity/features/user_managment/data/usecase/change_password_usecase.dart'
    as _i21;
import 'package:charja_charity/features/user_managment/data/usecase/forget_password_usecase.dart'
    as _i9;
import 'package:charja_charity/features/user_managment/data/usecase/get_category_usecase.dart'
    as _i15;
import 'package:charja_charity/features/user_managment/data/usecase/login_usecse.dart'
    as _i6;
import 'package:charja_charity/features/user_managment/data/usecase/login_with_google.dart'
    as _i13;
import 'package:charja_charity/features/user_managment/data/usecase/logout_usecase.dart'
    as _i11;
import 'package:charja_charity/features/user_managment/data/usecase/payment_usecase.dart'
    as _i20;
import 'package:charja_charity/features/user_managment/data/usecase/resend_otp_usecase.dart'
    as _i12;
import 'package:charja_charity/features/user_managment/data/usecase/signup_usecase.dart'
    as _i8;
import 'package:charja_charity/features/user_managment/data/usecase/supscription_usecase.dart'
    as _i18;
import 'package:charja_charity/features/user_managment/data/usecase/verfiy_code_forget_password.dart'
    as _i19;
import 'package:charja_charity/features/user_managment/data/usecase/verify_usecase.dart'
    as _i10;
import 'package:dartz/dartz.dart' as _i23;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeResult_0<Data> extends _i1.SmartFake implements _i2.Result<Data> {
  _FakeResult_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [AuthRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthRepository extends _i1.Mock implements _i3.AuthRepository {
  MockAuthRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Result<_i5.LoginModel>> getLogin(
          {required _i6.GetLoginParams? params}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getLogin,
          [],
          {#params: params},
        ),
        returnValue: _i4.Future<_i2.Result<_i5.LoginModel>>.value(
            _FakeResult_0<_i5.LoginModel>(
          this,
          Invocation.method(
            #getLogin,
            [],
            {#params: params},
          ),
        )),
      ) as _i4.Future<_i2.Result<_i5.LoginModel>>);
  @override
  _i4.Future<_i2.Result<_i7.UserModel>> signUp(
          {required _i8.SignUpParams? params}) =>
      (super.noSuchMethod(
        Invocation.method(
          #signUp,
          [],
          {#params: params},
        ),
        returnValue: _i4.Future<_i2.Result<_i7.UserModel>>.value(
            _FakeResult_0<_i7.UserModel>(
          this,
          Invocation.method(
            #signUp,
            [],
            {#params: params},
          ),
        )),
      ) as _i4.Future<_i2.Result<_i7.UserModel>>);
  @override
  _i4.Future<_i2.Result<bool>> forgetPassword(
          {required _i9.ForgetPasswordParams? params}) =>
      (super.noSuchMethod(
        Invocation.method(
          #forgetPassword,
          [],
          {#params: params},
        ),
        returnValue: _i4.Future<_i2.Result<bool>>.value(_FakeResult_0<bool>(
          this,
          Invocation.method(
            #forgetPassword,
            [],
            {#params: params},
          ),
        )),
      ) as _i4.Future<_i2.Result<bool>>);
  @override
  _i4.Future<_i2.Result<_i5.LoginModel>> getUserInfo(
          {required _i10.GetUserInfoParams? params}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getUserInfo,
          [],
          {#params: params},
        ),
        returnValue: _i4.Future<_i2.Result<_i5.LoginModel>>.value(
            _FakeResult_0<_i5.LoginModel>(
          this,
          Invocation.method(
            #getUserInfo,
            [],
            {#params: params},
          ),
        )),
      ) as _i4.Future<_i2.Result<_i5.LoginModel>>);
  @override
  _i4.Future<_i2.Result<bool>> LogOut({required _i11.LogOutParams? params}) =>
      (super.noSuchMethod(
        Invocation.method(
          #LogOut,
          [],
          {#params: params},
        ),
        returnValue: _i4.Future<_i2.Result<bool>>.value(_FakeResult_0<bool>(
          this,
          Invocation.method(
            #LogOut,
            [],
            {#params: params},
          ),
        )),
      ) as _i4.Future<_i2.Result<bool>>);
  @override
  _i4.Future<_i2.Result<bool>> ResendOTP(
          {required _i12.ResendOTPParams? params}) =>
      (super.noSuchMethod(
        Invocation.method(
          #ResendOTP,
          [],
          {#params: params},
        ),
        returnValue: _i4.Future<_i2.Result<bool>>.value(_FakeResult_0<bool>(
          this,
          Invocation.method(
            #ResendOTP,
            [],
            {#params: params},
          ),
        )),
      ) as _i4.Future<_i2.Result<bool>>);
  @override
  _i4.Future<_i2.Result<_i5.LoginModel>> loginWithGoogle(
          {required _i13.GetLoginWithGoogleParams? params}) =>
      (super.noSuchMethod(
        Invocation.method(
          #loginWithGoogle,
          [],
          {#params: params},
        ),
        returnValue: _i4.Future<_i2.Result<_i5.LoginModel>>.value(
            _FakeResult_0<_i5.LoginModel>(
          this,
          Invocation.method(
            #loginWithGoogle,
            [],
            {#params: params},
          ),
        )),
      ) as _i4.Future<_i2.Result<_i5.LoginModel>>);
  @override
  _i4.Future<_i2.Result<List<_i14.Activities>>> getCategories(
          {required _i15.GetCategoriesParams? params}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getCategories,
          [],
          {#params: params},
        ),
        returnValue: _i4.Future<_i2.Result<List<_i14.Activities>>>.value(
            _FakeResult_0<List<_i14.Activities>>(
          this,
          Invocation.method(
            #getCategories,
            [],
            {#params: params},
          ),
        )),
      ) as _i4.Future<_i2.Result<List<_i14.Activities>>>);
  @override
  _i4.Future<_i2.Result<_i14.UserInfo>> assignCategory(
          {required _i16.AssignCategoryParams? params}) =>
      (super.noSuchMethod(
        Invocation.method(
          #assignCategory,
          [],
          {#params: params},
        ),
        returnValue: _i4.Future<_i2.Result<_i14.UserInfo>>.value(
            _FakeResult_0<_i14.UserInfo>(
          this,
          Invocation.method(
            #assignCategory,
            [],
            {#params: params},
          ),
        )),
      ) as _i4.Future<_i2.Result<_i14.UserInfo>>);
  @override
  _i4.Future<_i2.Result<List<_i17.Supscription>>> getPackegs(
          {required _i18.SupscriptionParams? params}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getPackegs,
          [],
          {#params: params},
        ),
        returnValue: _i4.Future<_i2.Result<List<_i17.Supscription>>>.value(
            _FakeResult_0<List<_i17.Supscription>>(
          this,
          Invocation.method(
            #getPackegs,
            [],
            {#params: params},
          ),
        )),
      ) as _i4.Future<_i2.Result<List<_i17.Supscription>>>);
  @override
  _i4.Future<_i2.Result<bool>> ForgetPasswordOtp(
          {required _i19.ForgetPasswordOtpParams? params}) =>
      (super.noSuchMethod(
        Invocation.method(
          #ForgetPasswordOtp,
          [],
          {#params: params},
        ),
        returnValue: _i4.Future<_i2.Result<bool>>.value(_FakeResult_0<bool>(
          this,
          Invocation.method(
            #ForgetPasswordOtp,
            [],
            {#params: params},
          ),
        )),
      ) as _i4.Future<_i2.Result<bool>>);
  @override
  _i4.Future<_i2.Result<_i7.UserModel>> addPayment(
          {required _i20.PaymentParams? params}) =>
      (super.noSuchMethod(
        Invocation.method(
          #addPayment,
          [],
          {#params: params},
        ),
        returnValue: _i4.Future<_i2.Result<_i7.UserModel>>.value(
            _FakeResult_0<_i7.UserModel>(
          this,
          Invocation.method(
            #addPayment,
            [],
            {#params: params},
          ),
        )),
      ) as _i4.Future<_i2.Result<_i7.UserModel>>);
  @override
  _i4.Future<_i2.Result<bool>> ChangePassword(
          {required _i21.ChangePasswordParams? params}) =>
      (super.noSuchMethod(
        Invocation.method(
          #ChangePassword,
          [],
          {#params: params},
        ),
        returnValue: _i4.Future<_i2.Result<bool>>.value(_FakeResult_0<bool>(
          this,
          Invocation.method(
            #ChangePassword,
            [],
            {#params: params},
          ),
        )),
      ) as _i4.Future<_i2.Result<bool>>);
  @override
  _i2.Result<Model> call<Model extends _i22.BaseModel>(
          {required _i23.Either<_i24.BaseError, _i22.BaseModel>? result}) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [],
          {#result: result},
        ),
        returnValue: _FakeResult_0<Model>(
          this,
          Invocation.method(
            #call,
            [],
            {#result: result},
          ),
        ),
      ) as _i2.Result<Model>);
  @override
  _i2.Result<List<Model>> paginatedCall<Model extends _i22.BaseModel>(
          {required _i23.Either<_i24.BaseError, _i22.BaseModel>? result}) =>
      (super.noSuchMethod(
        Invocation.method(
          #paginatedCall,
          [],
          {#result: result},
        ),
        returnValue: _FakeResult_0<List<Model>>(
          this,
          Invocation.method(
            #paginatedCall,
            [],
            {#result: result},
          ),
        ),
      ) as _i2.Result<List<Model>>);
  @override
  _i2.Result<bool> noModelCall(
          {required _i23.Either<_i24.BaseError, bool>? result}) =>
      (super.noSuchMethod(
        Invocation.method(
          #noModelCall,
          [],
          {#result: result},
        ),
        returnValue: _FakeResult_0<bool>(
          this,
          Invocation.method(
            #noModelCall,
            [],
            {#result: result},
          ),
        ),
      ) as _i2.Result<bool>);
}
