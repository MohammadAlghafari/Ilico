part of 'example_cubit.dart';

abstract class ExampleCubitState {}

class ExampleCubitInitial extends ExampleCubitState {}

class ExampleLoading extends ExampleCubitState {}

class ExampleLoaded extends ExampleCubitState {
  final bool exampleModel;

  ExampleLoaded({required this.exampleModel});
}

class ExampleError extends ExampleCubitState {
  ExampleError({this.error, this.callback});
  final BaseError? error;
  final VoidCallback? callback;
}
