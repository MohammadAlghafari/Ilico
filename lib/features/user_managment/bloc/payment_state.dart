part of 'payment_cubit.dart';

@immutable
abstract class PaymentState {}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentLoaded extends PaymentState {
  final UserModel data;

  PaymentLoaded({required this.data});
}

class PaymentError extends PaymentState {
  PaymentError({this.error, this.callback});
  final BaseError? error;
  final VoidCallback? callback;
}
