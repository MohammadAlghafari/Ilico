import 'package:charja_charity/features/add_section/data/model/deleteEventModel.dart';
import 'package:charja_charity/features/add_section/data/queries.dart';
import 'package:charja_charity/features/add_section/data/repository/add_section_repostory.dart';

import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';

class DeleteEventParams extends BaseParams {
  final String id;

  DeleteEventParams({required this.id}) : super(query: deleteEventQueries);

  Map<String, dynamic> toJson() {
    return {
      "eventId": id,
    };
  }
}

class DeleteEventUseCase extends UseCase<DeleteEventModel, DeleteEventParams> {
  final AddSectionRepostory repository;

  DeleteEventUseCase(this.repository);

  @override
  Future<Result<DeleteEventModel>> call({required DeleteEventParams params}) {
    return repository.deleteEvent(params: params);
  }
}
