import 'package:charja_charity/features/user_managment/data/model/supscription_model.dart';
import 'package:charja_charity/features/user_managment/data/repository/auth_repository.dart';

import '../../../../core/boilerplate/pagination/models/get_list_request.dart';
import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';

class SupscriptionParams extends BaseParams {
  SupscriptionParams({required this.request});
  final GetListRequest request;

  Map<String, dynamic> tojson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data.addAll(request.toJson());

    return data;
  }
}

class SupscriptionUseCase extends UseCase<List<Supscription>, SupscriptionParams> {
  final AuthRepository repository;

  SupscriptionUseCase(this.repository);

  @override
  Future<Result<List<Supscription>>> call({required SupscriptionParams params}) {
    return repository.getPackegs(params: params);
  }
}
