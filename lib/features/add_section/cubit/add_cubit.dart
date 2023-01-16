import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:charja_charity/features/add_section/data/model/file_data.dart';
import 'package:charja_charity/features/add_section/data/repository/add_section_repostory.dart';
import 'package:charja_charity/features/add_section/data/usecase/upload_file_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/errors/base_error.dart';

part 'add_state.dart';

class AddCubit extends Cubit<AddState> {
  AddCubit() : super(AddInitial());
  static AddCubit get(context) => BlocProvider.of(context);

  Future<void> uploadfile({required GetFileParams params}) async {
    emit(AddLoading());
    final result = await GetUploadFileUseCase(AddSectionRepostory()).call(params: params);

    if (result.hasDataOnly) {
      emit(AddLoaded(data: result.data!));
    } else if (result.hasErrorOnly) {
      emit(AddError(
          error: result.error,
          callback: () {
            uploadfile(params: params);
          }));
    }
  }
}
