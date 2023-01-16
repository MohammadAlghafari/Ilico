import 'package:charja_charity/core/repository/core_repository.dart';
import 'package:charja_charity/features/example/data/usecase/get_subjects.dart';

import '../../../../core/constants/end_point.dart';
import '../../../../core/data_source/remote_data_source.dart';
import '../../../../core/http/http_method.dart';
import '../../../../core/results/result.dart';
import '../model/example_model.dart';
import '../model/subject_model.dart';
import '../usecase/example_usecase.dart';
import '../usecase/live_template_usecase.dart';

class ExampleRepository extends CoreRepository {
  Future<Result<bool>> getExample({required GetExampleParams params}) async {
    final result = await RemoteDataSource.noModelRequest(
      withAuthentication: false,
      url: kExampleUrl,
      method: HttpMethod.POST,
      data: {
        "roleKey": "Customer",
        "name": "lekaa",
        "phoneNumber": "alawad",
        "email": "lekaa.aaalawad@yopmail.com",
        "password": "123456Qwert@",
        "isCustomer": true
      },
      //queryParameters: {'id': params.id},
      // responseStr: 'ExampleResponse',
      // converter: (json) => ExampleResponse.fromJson(json),
    );
    return noModelCall(result: result);
  }

  Future<Result<ExampleModel>> getExample2({required LiveTemplateParams params}) async {
    final result = await RemoteDataSource.request(
        url: kExampleUrl,
        method: HttpMethod.GET,
        responseStr: 'ExampleResponse',
        converter: (json) => ExampleResponse.fromJson(json));
    return call(result: result);
  }

  Future<Result<ExampleModel>> getTest({required GetExampleParams params}) async {
    final result = await RemoteDataSource.request(
        withAuthentication: false,
        url: kExampleUrl,
        method: HttpMethod.GET,
        responseStr: 'ExampleResponse',
        converter: (json) => ExampleResponse.fromJson(json));
    return call(result: result);
  }

  Future<Result<List<ExampleItem>>> getSubjects({required GetSubjectParams params}) async {
    print(params);
    final result = await RemoteDataSource.request(
        withAuthentication: false,
        url: pagingUrl,
        method: HttpMethod.GET,
        queryParameters: params.tojson(),
        data: {},
        responseStr: 'SubjectResponse',
        converter: (json) => SubjectResponse.fromJson(json));
    return paginatedCall(result: result);
  }
}
