import 'package:charja_charity/features/add_section/data/model/add_media_model.dart';
import 'package:charja_charity/features/add_section/data/repository/add_section_repostory.dart';

import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../queries.dart';

class AddMediaParams extends BaseParams {
  String? media;
  String? type;
  AddMediaParams({this.media, this.type}) : super(query: addMediaQueries);
  toJson() {
    return {
      "createGalleryDto": {"media": media, "type": type}
    };
  }
}

class AddMediaUseCase extends UseCase<AddMediaModel, AddMediaParams> {
  final AddSectionRepostory repository;

  AddMediaUseCase(this.repository);

  @override
  Future<Result<AddMediaModel>> call({required AddMediaParams params}) {
    return repository.addMedia(params: params);
  }
}
