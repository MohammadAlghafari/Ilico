import 'package:charja_charity/core/constants/end_point.dart';
import 'package:charja_charity/features/add_section/data/model/addEvent_model.dart';
import 'package:charja_charity/features/add_section/data/model/deleteEventModel.dart';
import 'package:charja_charity/features/add_section/data/model/file_data.dart';
import 'package:charja_charity/features/add_section/data/model/new_service.dart';
import 'package:charja_charity/features/add_section/data/model/search_article.dart';
import 'package:charja_charity/features/add_section/data/usecase/add_service_usecase.dart';
import 'package:charja_charity/features/add_section/data/usecase/delete_event_usecase.dart';
import 'package:charja_charity/features/add_section/data/usecase/delete_service_product_usecase.dart';
import 'package:charja_charity/features/add_section/data/usecase/update_event_usecase.dart';
import 'package:charja_charity/features/add_section/data/usecase/update_service_usecase.dart';

import '../../../../core/data_source/remote_data_source.dart';
import '../../../../core/http/graphQl_provider.dart';
import '../../../../core/http/http_method.dart';
import '../../../../core/repository/core_repository.dart';
import '../../../../core/results/result.dart';
import '../model/add_media_model.dart';
import '../model/getEventModel.dart';
import '../model/get_article_model.dart';
import '../model/get_media_model.dart';
import '../model/get_product_model.dart';
import '../usecase/add_article_usecase.dart';
import '../usecase/add_event_usecase.dart';
import '../usecase/add_media_usecase.dart';
import '../usecase/delete_article_usecase.dart';
import '../usecase/delete_media_usecase.dart';
import '../usecase/edit_article.dart';
import '../usecase/get_article_usecase.dart';
import '../usecase/get_event_usecase.dart';
import '../usecase/get_media_usecase.dart';
import '../usecase/get_product_usecase.dart';
import '../usecase/search_of_service_by_name_usecase.dart';
import '../usecase/upload_file_usecase.dart';

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

  Future<Result<bool>> deleteServiceOrProduct({required DeleteServiceProductParams params}) async {
    final result = await RemoteDataSource.noModelRequest(
        //data: params.toJson(),
        withAuthentication: true,
        url: getdeleteServiceProductsURL(params.type) + '/${params.id}',
        method: HttpMethod.DELETE,
        queryParameters: params.toJson());
    return noModelCall(result: result);
  }

  Future<Result<AddService>> updateService({required UpdateServiceParams params}) async {
    final result = await RemoteDataSource.request(
        withAuthentication: true,
        data: params.toJson(),
        url: updateServiceURL(params.type!) + '/${params.id}',
        //queryParameters: {"id": params.id},
        method: HttpMethod.PUT,
        responseStr: 'AddServiceResponse',
        converter: (json) => AddServiceResponse.fromJson(json));
    return call(result: result);
  }

  Future<Result<AddEventModel>> addEvent({required AddEventParams params}) async {
    final result = await RemoteDataSource.qlRequest(
        withAuthentication: false,
        params: params.toJson(),
        query: params.query!,
        method: QlMethod.mutations,
        responseStr: 'AddEventModel',
        converter: (json) => AddEventModel.fromJson(json),
        modelKey: 'createEvent');
    return call(result: result);
  }

  Future<Result<AddEventModel>> updateEvent({required UpdateEventParams params}) async {
    final result = await RemoteDataSource.qlRequest(
        withAuthentication: false,
        params: params.toJson(),
        query: params.query!,
        method: QlMethod.mutations,
        responseStr: 'AddEventModel',
        converter: (json) => AddEventModel.fromJson(json),
        modelKey: 'updateEvent');
    return call(result: result);
  }

  Future<Result<DeleteEventModel>> deleteEvent({required DeleteEventParams params}) async {
    final result = await RemoteDataSource.qlRequest(
      withAuthentication: true,
      query: params.query!,
      method: QlMethod.mutations,
      params: params.toJson(),
      responseStr: 'DeleteEventModel',
      converter: (json) => DeleteEventModel.fromJson(json),
      modelKey: '',
    );
    return call(result: result);
  }

  Future<Result<List<AddService>>> getProduct({required GetProductParams params}) async {
    final result = await RemoteDataSource.request(
        withAuthentication: true,
        queryParameters: params.tojson(),
        // data: params.toJson(),
        url: urlAccordingType(params: params),
        method: HttpMethod.GET,
        responseStr: 'GetProductResponse',
        converter: (json) => GetProductResponse.fromJson(json));
    return paginatedCall(result: result);
  }

  Future<Result<List<GetMyArticles>>> getArticle({required GetArticleParams params}) async {
    final result = await RemoteDataSource.qlRequest(
        withAuthentication: false,
        withCash: false,
        method: QlMethod.query,
        params: params.toJson(),
        responseStr: 'GetArticle',
        converter: (json) => GetArticle.fromJson(json),
        query: params.query!,
        modelKey: 'getMyArticles');
    return paginatedCall(result: result);
  }

  Future<Result<SearchList>> getSearch({required SearchArticleParams params}) async {
    final result = await RemoteDataSource.qlRequest(
      withAuthentication: false,
      withCash: false,
      method: QlMethod.query,
      params: params.toJson(),
      responseStr: 'SearchList',
      converter: (json) => SearchList.fromJson(json),
      query: params.query!,
      modelKey: '',
    );
    //   (CashHelper.getRole() == 'ServiceProvider') ? "searchOfInfluencerByName" : 'searchOfServiceProviderByName');
    return call(result: result);
  }

  Future<Result<CreateArticle>> createArticle({required AddArticleParams params}) async {
    final result = await RemoteDataSource.qlRequest(
        withAuthentication: false,
        withCash: false,
        params: params.toJson(),
        query: params.query!,
        method: QlMethod.mutations,
        responseStr: 'CreateArticle',
        converter: (json) => CreateArticle.fromJson(json),
        modelKey: 'createArticle');
    return call(result: result);
  }

  Future<Result<CreateArticle>> editArticle({required EditArticleParams params}) async {
    final result = await RemoteDataSource.qlRequest(
        withAuthentication: false,
        withCash: false,
        params: params.toJson(),
        query: params.query!,
        method: QlMethod.mutations,
        responseStr: 'CreateArticle',
        converter: (json) => CreateArticle.fromJson(json),
        modelKey: 'updateArticle');
    return call(result: result);
  }

  Future<Result<GetMyArticles>> deleteArticle({required DeleteArticleParams params}) async {
    final result = await RemoteDataSource.qlRequest(
        withAuthentication: false,
        withCash: false,
        params: params.toJson(),
        query: params.query!,
        method: QlMethod.mutations,
        responseStr: 'GetMyArticles',
        converter: (json) => GetMyArticles.fromJson(json),
        modelKey: 'deleteArticle');
    return call(result: result);
  }

  Future<Result<List<AddEventModel>>> getEvent({required GetEventParams params}) async {
    final result = await RemoteDataSource.qlRequest(
        withAuthentication: false,
        withCash: false,
        method: QlMethod.query,
        params: params.toJson(),
        responseStr: 'GetEventList',
        converter: (json) => GetEventList.fromJson(json),
        query: params.query!,
        modelKey: 'getAllEventsByServiceProvider');
    return paginatedCall(result: result);
  }

  Future<Result<AddMediaModel>> addMedia({required AddMediaParams params}) async {
    final result = await RemoteDataSource.qlRequest(
        withAuthentication: false,
        params: params.toJson(),
        query: params.query!,
        method: QlMethod.mutations,
        responseStr: 'AddMediaModel',
        converter: (json) => AddMediaModel.fromJson(json),
        modelKey: 'addMedia');
    return call(result: result);
  }

  Future<Result<List<AddMediaModel>>> getMedia({required GetMediaParams params}) async {
    final result = await RemoteDataSource.qlRequest(
        withAuthentication: true,
        withCash: false,
        method: QlMethod.query,
        params: params.toJson(),
        responseStr: 'GetMediaList',
        converter: (json) => GetMediaList.fromJson(json),
        query: params.query!,
        modelKey: 'getMyGallery');
    return paginatedCall(result: result);
  }

  Future<Result<AddMediaModel>> deleteMedia({required DeleteMediaParams params}) async {
    final result = await RemoteDataSource.qlRequest(
      withAuthentication: true,
      query: params.query!,
      method: QlMethod.mutations,
      params: params.toJson(),
      responseStr: 'AddMediaModel',
      converter: (json) => AddMediaModel.fromJson(json),
      modelKey: 'deleteMedia',
    );
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

  String getdeleteServiceProductsURL(int type) {
    if (type == 1) {
      return DELETE_SERVICE;
    } else if (type == 2) {
      return DELETE_PRODUCT;
    } else if (type == 3) {
      return " ";
    } else {
      return " ";
    }
  }

  String updateServiceURL(int type) {
    if (type == 1) {
      return UPDATE_SERVICE;
    } else if (type == 2) {
      return UPDATE_PRODUCT;
    } else if (type == 3) {
      return " ";
    } else {
      return " ";
    }
  }

  String urlAccordingType({required GetProductParams params}) {
    if (params.type == "getProduct") {
      return Get_PRODUCT;
    } else if (params.type == "getService") {
      return Get_SERVICE;
    } else if (params.type == "getEvent") {
      return ""; // todo url get event
    }
    return "";
  }
}
