import '../../../../core/boilerplate/pagination/models/get_list_request.dart';
import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../profile/data/model/profile_model.dart';
import '../repository/auth_repository.dart';

class GetCategoriesParams extends BaseParams {
  GetCategoriesParams({
    required this.request,
  });
  final GetListRequest request;

  Map<String, dynamic> tojson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data.addAll(request.toJson());

    return data;
  }
}

class GetCategoriesUseCase extends UseCase<List<Activities>, GetCategoriesParams> {
  final AuthRepository repository;

  GetCategoriesUseCase(this.repository);

  @override
  Future<Result<List<Activities>>> call({required GetCategoriesParams params}) async {
    return repository.getCategories(params: params);
  }
}
