import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:charja_charity/features/add_section/data/model/new_service.dart';
import 'package:charja_charity/features/add_section/data/repository/add_section_repostory.dart';
import 'package:charja_charity/features/add_section/data/usecase/add_service_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/errors/base_error.dart';
import '../../../core/results/result.dart';
import '../data/usecase/upload_file_usecase.dart';

part 'add_service_state.dart';

class AddServiceCubit extends Cubit<AddServiceState> {
  AddServiceCubit() : super(AddServiceInitial());
  static AddServiceCubit get(context) => BlocProvider.of(context);

  Future<void> addService({required GetFileParams params, required AddServiceParams addServiceParams}) async {
    emit(AddServiceLoading());
    Result uploadResult;

    Result editResult;
    if (params.file != null && params.file.isNotEmpty) {
      uploadResult = await GetUploadFileUseCase(AddSectionRepostory()).call(params: params);
      if (uploadResult.hasErrorOnly) {
        emit(AddServiceError(
            error: uploadResult.error,
            callback: () {
              addService(params: params, addServiceParams: addServiceParams);
            }));
        return Future.value();
      } else {
        addServiceParams.files = uploadResult.data;
      }
    }
    editResult = await AddServiceUseCase(AddSectionRepostory()).call(params: addServiceParams);
    if (editResult.hasDataOnly) {
      emit(AddServiceLoaded(data: editResult.data));
    } else if (editResult.hasErrorOnly) {
      emit(AddServiceError(
          error: editResult.error,
          callback: () {
            addService(params: params, addServiceParams: addServiceParams);
          }));
    }
  }
}
