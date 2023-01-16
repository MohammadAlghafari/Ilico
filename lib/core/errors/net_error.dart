import 'http_error.dart';

class NetError extends HttpError {
  const NetError({required this.message});
  @override
  final List<dynamic> message;
}
