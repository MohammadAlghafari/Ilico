import 'package:charja_charity/features/add_section/data/model/add_media_model.dart';
import 'package:charja_charity/features/add_section/data/repository/add_section_repostory.dart';

import '../../../../core/boilerplate/pagination/models/get_list_request.dart';
import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../queries.dart';

class GetMediaParams extends BaseParams {
  final GetListRequest request;
  GetMediaParams({required this.request}) : super(query: getMediaQueries);
  Map<String, dynamic> toJson() {
    return {
      "pageOptionsDto": request.toJson(),
    };
  }
}

class GetMediaUseCase extends UseCase<List<AddMediaModel>, GetMediaParams> {
  final AddSectionRepostory repository;

  GetMediaUseCase(this.repository);

  @override
  Future<Result<List<AddMediaModel>>> call({required GetMediaParams params}) {
    return repository.getMedia(params: params);
  }
}
