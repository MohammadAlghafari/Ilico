part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class EditProfileLoading extends ProfileState {}

class EditProfileSuccess extends ProfileState {
  EditProfileSuccess({required this.data});
  final UserInfo data;
}

class EditProfileError extends ProfileState {
  EditProfileError({this.error, this.callback});
  final BaseError? error;
  final VoidCallback? callback;
}
