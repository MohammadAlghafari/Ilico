import 'package:charja_charity/core/constants/end_point.dart';
import 'package:charja_charity/features/add_section/data/model/file_data.dart';
import 'package:charja_charity/features/add_section/data/model/new_service.dart';
import 'package:charja_charity/features/add_section/data/usecase/add_service_usecase.dart';
import 'package:charja_charity/features/add_section/data/usecase/upload_file_usecase.dart';

import '../../../../core/data_source/remote_data_source.dart';
import '../../../../core/http/http_method.dart';
import '../../../../core/repository/core_repository.dart';
import '../../../../core/results/result.dart';

class AddSectionRepostory extends CoreRepository {
  Future<Result<FileData>> uploadFiles({required GetFileParams params}) async {
    final result = await RemoteDataSource.upload(
        withAuthentication: true,
        files: params.file,
        queryParameters: {"type": params.type},
        url: uploadfile_URL,
        // method: HttpMethod.POST,
        responseStr: 'FileData',
        converter: (json) => FileData.fromJson(json),
        fileKey: 'files');
    return call(result: result);
  }

  Future<Result<AddService>> addService({required AddServiceParams params}) async {
    final result = await RemoteDataSource.request(
        withAuthentication: true,
        data: params.toJson(),
        url: getServiceURL(params.type!),
        method: HttpMethod.POST,
        responseStr: 'AddServiceResponse',
        converter: (json) => AddServiceResponse.fromJson(json));
    return call(result: result);
  }

  String getServiceURL(int type) {
    if (type == 1) {
      return ADD_SERVICE;
    } else if (type == 2) {
      return ADD_PRODUCT;
    } else if (type == 3) {
      return " ";
    } else {
      return " ";
    }
  }
}
