import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:charja_charity/features/user_managment/data/model/user_model.dart';
import 'package:charja_charity/features/user_managment/data/usecase/payment_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/errors/base_error.dart';
import '../data/repository/auth_repository.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());
  static PaymentCubit get(context) => BlocProvider.of(context);
  Future<void> addPayment(PaymentParams params) async {
    emit(PaymentLoading());

    final result = await PaymentUseCase(AuthRepository()).call(params: params);
    if (result.hasErrorOnly) {
      emit(PaymentError(
        callback: () {
          addPayment(params);
        },
        error: result.error,
      ));
    } else if (result.hasDataOnly) {
      emit(PaymentLoaded(data: result.data!));
    }
  }

  Future<void> startPay() async {
    emit(PaymentLoading());
  }

  Future<void> errorPay() async {
    emit(PaymentError());
  }
}
