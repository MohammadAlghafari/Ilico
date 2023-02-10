import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:charja_charity/features/user_managment/data/repository/auth_repository.dart';
import 'package:charja_charity/features/user_managment/data/usecase/login_with_google.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/errors/base_error.dart';
import '../model/login_model.dart';
import '../usecase/facebook_login_ussecase.dart';
import '../usecase/login_apple_usecase.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);

  AuthRepository repository = AuthRepository();

  Future<void> getGoogleWithLogin({String? id, String? email}) async {
    emit(LoginLoading());

    final result = await GetLoginWithGoogleUseCase(AuthRepository())
        .call(params: GetLoginWithGoogleParams(googleProfileId: id, email: email));
    if (result.hasErrorOnly) {
      emit(LoginError(
        callback: () {
          getGoogleWithLogin(email: email, id: id);
        },
        error: result.error,
      ));
    } else if (result.hasDataOnly) {
      emit(LoginSuccess(loginModel: result.data!));
    }
  }

  Future<void> getFacebookWithLogin({String? id, String? email}) async {
    emit(LoginLoading());

    final result = await GetLoginWithFacebookUseCase(AuthRepository())
        .call(params: GetLoginWithFacebookParams(facebookProfileId: id, email: email));
    if (result.hasErrorOnly) {
      emit(LoginError(
        callback: () {
          getFacebookWithLogin(email: email, id: id);
        },
        error: result.error,
      ));
    } else if (result.hasDataOnly) {
      emit(LoginSuccess(loginModel: result.data!));
    }
  }

  Future<void> getAppleWithLogin({String? appleProfileId, String? email}) async {
    emit(LoginLoading());

    final result = await LoginWithAppleUseCase(AuthRepository())
        .call(params: LoginWithAppleParams(appleProfileId: appleProfileId, email: email));
    if (result.hasErrorOnly) {
      emit(LoginError(
        callback: () {
          getAppleWithLogin(email: email, appleProfileId: appleProfileId);
        },
        error: result.error,
      ));
    } else if (result.hasDataOnly) {
      emit(LoginSuccess(loginModel: result.data!));
    }
  }
}
