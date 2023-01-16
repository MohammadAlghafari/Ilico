import 'base_error.dart';

class TimeoutError extends BaseError {
  const TimeoutError({this.errorMessage}) : super(message: errorMessage);
  final List<dynamic>? errorMessage;
  @override
  List<Object?> get props => throw UnimplementedError();
}
