import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositoy/example_repo_imp.dart';

class GetExampleParams extends BaseParams {
  final String? id;

  GetExampleParams({this.id});
}

class GetExampleUseCase extends UseCase<bool, GetExampleParams> {
  //UseCase<Type, Params extends BaseParams>
  final ExampleRepository repository;

  GetExampleUseCase(this.repository);

  @override
  Future<Result<bool>> call({required GetExampleParams params}) {
    return repository.getExample(params: params);
  }
}
//abstract class UseCase<Type, Params extends BaseParams> {
//   Future<Result<Type>> call({required Params params});
// }
