import 'package:charja_charity/features/add_section/data/repository/add_section_repostory.dart';

import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';

class DeleteServiceProductParams extends BaseParams {
  final String id;
  final int type;
  DeleteServiceProductParams({required this.id, required this.type});
  toJson() {
    return {
      "id": id,
    };
  }
}

class DeleteServiceProductUseCase extends UseCase<bool, DeleteServiceProductParams> {
  final AddSectionRepostory repository;

  DeleteServiceProductUseCase(this.repository);

  @override
  Future<Result<bool>> call({required DeleteServiceProductParams params}) {
    return repository.deleteServiceOrProduct(params: params);
  }
}
