import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../core/errors/base_error.dart';
import '../../profile/data/model/profile_model.dart';
import '../../profile/data/profile_repository/profile_repository.dart';
import '../../profile/data/use_case/edit_company_service_provider.dart';
import '../data/repository/auth_repository.dart';
import '../data/usecase/assign_category.dart';

part 'service_provider_state.dart';

class ServiceProviderCubit extends Cubit<ServiceProviderState> {
  ServiceProviderCubit() : super(ServiceProviderInitial());

  Future<void> confirm(List<String?> categoryIds, EditCompanyProfileParams params) async {
    emit(SPCategoryLoading());

    final result = await AssignCategoryUseCase(AuthRepository())
        .call(params: AssignCategoryParams(categoriesIds: categoryIds)); //api assignCategoryService
    if (result.hasErrorOnly) {
      emit(SPCategoryError(
        callback: () {
          confirm(categoryIds, params);
        },
        error: result.error,
      ));
    } else if (result.hasDataOnly) {
      final editCompanyResult = await EditCompanyProfileUseCase(ProfileRepository()) //edit company
          .call(params: params);
      if (editCompanyResult.hasDataOnly) {
        emit(SPCategoryLoaded(data: editCompanyResult.data!));
      } else {
        emit(SPCategoryError(
          callback: () {
            confirm(categoryIds, params);
          },
          error: result.error,
        ));
      }
    }
  }
}
