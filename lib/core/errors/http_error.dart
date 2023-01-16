import './base_error.dart';

class HttpError extends BaseError {
  const HttpError({this.message});
  final List<dynamic>? message;

  @override
  List<Object> get props => [];
}
