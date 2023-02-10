import 'package:charja_charity/features/profile/data/profile_repository/profile_repository.dart';

import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../model/toggle_favorite_result.dart';
import '../queries.dart';

class ToggleFavoriteParams extends BaseParams {
  ToggleFavoriteParams({required this.profileId, required this.type}) : super(query: toggleFavoriteQueries);
  final String profileId;
  final String type;

  toJson() {
    return {
      "createFavoriteDto": {
        "profileId": profileId,
        "type": type,
      }
    };
  }
}

class ToggleFavoriteUseCase extends UseCase<ToggleFavoriteResult, ToggleFavoriteParams> {
  final ProfileRepository repository;

  ToggleFavoriteUseCase(this.repository);

  @override
  Future<Result<ToggleFavoriteResult>> call({required ToggleFavoriteParams params}) {
    return repository.toggleFavorite(params: params);
  }
}
