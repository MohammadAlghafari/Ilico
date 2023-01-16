import 'dart:ui';

import 'package:charja_charity/features/example/data/model/example_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/errors/base_error.dart';
import '../data/repositoy/example_repo_imp.dart';
import '../data/usecase/example_usecase.dart';

part 'example_cubit_state.dart';

class ExampleCubit extends Cubit<ExampleCubitState> {
  ExampleCubit() : super(ExampleCubitInitial());

  static ExampleCubit get(context) => BlocProvider.of(context);

  Future<void> getExample({required GetExampleParams params}) async {
    emit(ExampleLoading());
    final result = await GetExampleUseCase(ExampleRepository()).call(params: params);

    if (result.hasDataOnly) {
      emit(ExampleLoaded(exampleModel: result.data!));
    } else if (result.hasErrorOnly) {
      emit(ExampleError(
          error: result.error,
          callback: () {
            getExample(params: params);
          }));
    }
  }
}
