import 'package:charja_charity/features/example/data/model/example_model.dart';
import 'package:charja_charity/features/example/data/repositoy/example_repo_imp.dart';

import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';

/// LIVE TEMPLATE FOR USE CASE JUST TYPE usecase AND ADD THE THE NAME OF PARAMS AND USE CASE AND REPOSITORY.

class LiveTemplateParams extends BaseParams {
  LiveTemplateParams();
}

class LiveTemplateUseCase extends UseCase<ExampleModel, LiveTemplateParams> {
  final ExampleRepository repository;

  LiveTemplateUseCase(this.repository);

  @override
  Future<Result<ExampleModel>> call({required LiveTemplateParams params}) {
    return repository.getExample2(params: params);
  }
}
