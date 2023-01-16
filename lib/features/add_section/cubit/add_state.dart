part of 'add_cubit.dart';

@immutable
abstract class AddState {}

class AddInitial extends AddState {}

class AddLoading extends AddState {}

class AddLoaded extends AddState {
  final FileData data;

  AddLoaded({required this.data});
}

class AddError extends AddState {
  AddError({this.error, this.callback});
  final BaseError? error;
  final VoidCallback? callback;
}
