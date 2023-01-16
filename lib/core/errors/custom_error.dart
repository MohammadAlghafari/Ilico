import 'base_error.dart';

class CustomError extends BaseError {
  const CustomError({this.errorMessage}) : super(message: errorMessage);
  final List<dynamic>? errorMessage;

  @override
  List<Object> get props => [];
}
