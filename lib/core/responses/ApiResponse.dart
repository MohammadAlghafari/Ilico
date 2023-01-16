abstract class ApiResponse<T> {
  ApiResponse({
    this.errors,
    this.success,
    required this.data,
  });
  final List<dynamic>? errors;
  final bool? success;
  final T data;
}
