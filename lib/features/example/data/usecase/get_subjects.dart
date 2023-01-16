import 'package:charja_charity/features/example/data/repositoy/example_repo_imp.dart';

import '../../../../core/boilerplate/pagination/models/get_list_request.dart';
import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../model/example_model.dart';

class GetSubjectParams extends BaseParams {
  GetSubjectParams({required this.request, this.filter});

  final GetListRequest request;
  final String? filter;

  Map<String, dynamic> tojson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data.addAll(request.toJson());
    data['filter'] = filter;
    return data;
  }
}

class GetSubjectUseCase extends UseCase<List<ExampleItem>, GetSubjectParams> {
  final ExampleRepository repository;

  GetSubjectUseCase(this.repository);

  @override
  Future<Result<List<ExampleItem>>> call({required GetSubjectParams params}) {
    return repository.getSubjects(params: params);
  }
}
