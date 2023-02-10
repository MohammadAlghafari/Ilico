import 'package:charja_charity/features/add_section/data/repository/add_section_repostory.dart';

import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../model/add_media_model.dart';
import '../queries.dart';

class DeleteMediaParams extends BaseParams {
  String? id;
  DeleteMediaParams({required this.id}) : super(query: deleteMediaQueries);
  toJson() {
    return {"id": id};
  }
}

class DeleteMediaUseCase extends UseCase<AddMediaModel, DeleteMediaParams> {
  final AddSectionRepostory repository;

  DeleteMediaUseCase(this.repository);

  @override
  Future<Result<AddMediaModel>> call({required DeleteMediaParams params}) {
    return repository.deleteMedia(params: params);
  }
}
