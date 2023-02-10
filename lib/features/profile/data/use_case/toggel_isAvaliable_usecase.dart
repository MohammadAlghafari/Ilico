import 'package:charja_charity/features/profile/data/profile_repository/profile_repository.dart';

import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../search/data/model/search_model.dart';
import '../queries.dart';

class ToggleIsAvaliableParams extends BaseParams {
  ToggleIsAvaliableParams() : super(query: toggleIsAvialable);
}

class ToggleIsAvaliableUseCase extends UseCase<SearchOfServiceProvider, ToggleIsAvaliableParams> {
  final ProfileRepository repository;

  ToggleIsAvaliableUseCase(this.repository);

  @override
  Future<Result<SearchOfServiceProvider>> call({required ToggleIsAvaliableParams params}) {
    return repository.toggleIsAvailable(params: params);
  }
}
