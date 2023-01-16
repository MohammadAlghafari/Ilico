part of 'live_template_cubit.dart';

@immutable
abstract class LiveTemplateState {}

class LiveTemplateInitial extends LiveTemplateState {}

// class LiveTemplateLoading extends LiveTemplateState {}
//
// class LiveTemplateLoaded extends LiveTemplateState {}
//
// class LiveTemplateError extends LiveTemplateState {
//   LiveTemplateError({this.error, this.callback});
//   final BaseError? error;
//   final VoidCallback? callback;
// }

class LiveTemplateLoading extends LiveTemplateState {}

class LiveTemplateLoaded extends LiveTemplateState {
  LiveTemplateLoaded();
}

class LiveTemplateError extends LiveTemplateState {
  LiveTemplateError({this.error, this.callback});
  final BaseError? error;
  final VoidCallback? callback;
}
