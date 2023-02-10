import 'package:charja_charity/features/add_section/data/model/addEvent_model.dart';
import 'package:charja_charity/features/add_section/data/queries.dart';

import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/add_section_repostory.dart';

class UpdateEventParams extends BaseParams {
  UpdateEventParams(
      {this.id, this.name, this.description, this.startDate, this.endDate, this.images, this.videos, this.type})
      : super(query: updateEventQueries);
  String? id;
  String? name;
  String? description;
  String? startDate;
  String? endDate;
  List<String>? images;
  List<String>? videos;

  int? type;

  toJson() {
    return {
      "updateEventDto": {
        "startDate": startDate,
        "endDate": endDate,
        "description": description,
        "images": images,
        "videos": videos,
        "name": name
      },
      "eventId": id
    };
  }
}

class UpdateEventUseCase extends UseCase<AddEventModel, UpdateEventParams> {
  final AddSectionRepostory repository;

  UpdateEventUseCase(this.repository);

  @override
  Future<Result<AddEventModel>> call({required UpdateEventParams params}) {
    return repository.updateEvent(params: params);
  }
}
