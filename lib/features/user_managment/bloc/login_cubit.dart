import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:charja_charity/features/user_managment/data/model/login_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/errors/base_error.dart';
import '../data/repository/auth_repository.dart';
import '../data/usecase/login_with_google.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  AuthRepository repository = AuthRepository();

  Future<void> getGoogleWithLogin() async {
    emit(LoginWithGoogleLoading());

    final result = await GetLoginWithGoogleUseCase(AuthRepository()).call(params: GetLoginWithGoogleParams());
    if (result.hasErrorOnly) {
      emit(LoginWithGoogleError(
        callback: () {
          getGoogleWithLogin();
        },
        error: result.error,
      ));
    } else if (result.hasDataOnly) {
      emit(LoginWithGoogleSuccess(loginModel: result.data!));
    }
  }
}
