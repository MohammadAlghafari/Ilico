import 'package:charja_charity/features/profile/data/model/SPArticleModel.dart';
import 'package:charja_charity/features/profile/data/profile_repository/profile_repository.dart';

import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';

class SPGetArticleParams extends BaseParams {
  final String id;
  final double latitude;
  final double longitude;
  final String query;
  SPGetArticleParams({required this.id, required this.latitude, required this.longitude, required this.query})
      : super(query: query);
  toJson() {
    return {
      "getProfileDto": {"latitude": latitude, "longitude": longitude, "serviceProviderId": id}
    };
  }
}

class SPGetArticleUseCase extends UseCase<SPArticleModel, SPGetArticleParams> {
  final ProfileRepository repository;

  SPGetArticleUseCase(this.repository);

  @override
  Future<Result<SPArticleModel>> call({required SPGetArticleParams params}) {
    return repository.getArticleById(params: params);
  }
}
