import 'package:charja_charity/features/add_section/data/model/addEvent_model.dart';
import 'package:charja_charity/features/add_section/data/repository/add_section_repostory.dart';

import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../queries.dart';

class AddEventParams extends BaseParams {
  String? name;
  String? description;
  List<String>? images;
  List<String>? videos;
  String? startdate;
  String? enddate;

  AddEventParams({this.name, this.description, this.images, this.videos, this.startdate, this.enddate})
      : super(query: createEventQueries);
  Map<String, dynamic> toJson() {
    return {
      "createEventDto": {
        "name": name?.trim(),
        "description": description?.trim(),
        "images": images,
        "videos": videos,
        "startDate": startdate,
        "endDate": enddate
      }
    };
  }
}

class AddEventUseCase extends UseCase<AddEventModel, AddEventParams> {
  final AddSectionRepostory repository;

  AddEventUseCase(this.repository);

  @override
  Future<Result<AddEventModel>> call({required AddEventParams params}) {
    return repository.addEvent(params: params);
  }
}
