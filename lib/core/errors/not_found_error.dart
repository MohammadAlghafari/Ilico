import './http_error.dart';

class NotFoundError extends HttpError {
  final int? code;

  NotFoundError({required List<String> message, this.code})
      : super(message: message);
}
