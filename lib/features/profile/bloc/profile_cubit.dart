import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:charja_charity/core/results/result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/errors/base_error.dart';
import '../../add_section/data/repository/add_section_repostory.dart';
import '../../add_section/data/usecase/upload_file_usecase.dart';
import '../data/model/profile_model.dart';
import '../data/profile_repository/profile_repository.dart';
import '../data/use_case/edit_profile_usecase.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  static ProfileCubit get(context) => BlocProvider.of(context);

  Future<void> editProfile({required GetFileParams params, required EditProfileParams editProfileParams}) async {
    emit(EditProfileLoading());
    Result uploadResult;

    Result editResult;
    if (params.file != null && params.file.isNotEmpty) {
      uploadResult = await GetUploadFileUseCase(AddSectionRepostory()).call(params: params);
      if (uploadResult.hasErrorOnly) {
        emit(EditProfileError(
            error: uploadResult.error,
            callback: () {
              editProfile(params: params, editProfileParams: editProfileParams);
            }));
        return Future.value();
      } else {
        editProfileParams.photoUrl = uploadResult.data.data.first.url;
      }
    }
    editResult = await EditProfileUseCase(ProfileRepository()).call(params: editProfileParams);
    if (editResult.hasDataOnly) {
      emit(EditProfileSuccess(data: editResult.data));
    } else if (editResult.hasErrorOnly) {
      emit(EditProfileError(
          error: editResult.error,
          callback: () {
            editProfile(params: params, editProfileParams: editProfileParams);
          }));
    }
  }
}
