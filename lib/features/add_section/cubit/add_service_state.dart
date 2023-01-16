part of 'add_service_cubit.dart';

@immutable
abstract class AddServiceState {}

class AddServiceInitial extends AddServiceState {}

class AddServiceLoading extends AddServiceState {}

/*
class AddServiceSuccess extends AddServiceState {
  AddServiceSuccess({required this.data});

}*/
class AddServiceLoaded extends AddServiceState {
  final AddService data;

  AddServiceLoaded({required this.data});
}

class AddServiceError extends AddServiceState {
  AddServiceError({this.error, this.callback});
  final BaseError? error;
  final VoidCallback? callback;
}
