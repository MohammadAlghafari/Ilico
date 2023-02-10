part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  LoginSuccess({required this.loginModel});
  final LoginModel loginModel;
}

class LoginError extends LoginState {
  LoginError({this.error, this.callback});
  final BaseError? error;
  final VoidCallback? callback;
}
