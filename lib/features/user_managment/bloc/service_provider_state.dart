part of 'service_provider_cubit.dart';

@immutable
abstract class ServiceProviderState {}

class ServiceProviderInitial extends ServiceProviderState {}

class SPCategoryLoading extends ServiceProviderState {}

class SPCategoryLoaded extends ServiceProviderState {
  final Company data;

  SPCategoryLoaded({required this.data});
}

class SPCategoryError extends ServiceProviderState {
  SPCategoryError({this.error, this.callback});
  final BaseError? error;
  final VoidCallback? callback;
}
