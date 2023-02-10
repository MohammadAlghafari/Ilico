import 'package:charja_charity/features/profile/data/profile_repository/profile_repository.dart';

import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../model/get_my_favorite_model.dart';
import '../queries.dart';

class GetMyFavoriteParams extends BaseParams {
  GetMyFavoriteParams({required this.type}) : super(query: getMyFavoriteQuery);

  final String type;

  toJson() {
    return {
      "type": type,
    };
  }
}

class GetMyFavoriteUseCase extends UseCase<GetMyFavoriteListModel, GetMyFavoriteParams> {
  final ProfileRepository repository;

  GetMyFavoriteUseCase(this.repository);

  @override
  Future<Result<GetMyFavoriteListModel>> call({required GetMyFavoriteParams params}) {
    return repository.getMyFavorite(params: params);
  }
}
