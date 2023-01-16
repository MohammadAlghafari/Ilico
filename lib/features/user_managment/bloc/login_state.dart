part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginWithGoogleLoading extends LoginState {}

class LoginWithGoogleSuccess extends LoginState {
  LoginWithGoogleSuccess({required this.loginModel});
  final LoginModel loginModel;
}

class LoginWithGoogleError extends LoginState {
  LoginWithGoogleError({this.error, this.callback});
  final BaseError? error;
  final VoidCallback? callback;
}

class LoginWithFacebookLoading extends LoginState {}

class LoginWithFacebookSuccess extends LoginState {}

class LoginWithFacebookError extends LoginState {
  LoginWithFacebookError({this.error, this.callback});
  final BaseError? error;
  final VoidCallback? callback;
}
