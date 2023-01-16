import 'package:equatable/equatable.dart';

abstract class BaseError extends Equatable {
  const BaseError({
    this.message,
  });
  final List<dynamic>? message;
}

class MessageModel {
  MessageModel({required this.message});
  final String message;
}
