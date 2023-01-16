import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../constants/end_point.dart';
import '../errors/bad_request_error.dart';
import '../errors/base_error.dart';
import '../errors/cancel_error.dart';
import '../errors/conflict_error.dart';
import '../errors/custom_error.dart';
import '../errors/forbidden_error.dart';
import '../errors/http_error.dart';
import '../errors/internal_server_error.dart';
import '../errors/net_error.dart';
import '../errors/not_found_error.dart';
import '../errors/socket_error.dart';
import '../errors/timeout_error.dart';
import '../errors/unauthorized_error.dart';
import '../errors/unknown_error.dart';
import '../utils/Navigation/Navigation.dart';
import 'http_method.dart';
import 'models_factory.dart';

class ApiProvider {
  static var options = BaseOptions(
    baseUrl: BASE_URL,
    connectTimeout: (kIsWeb) ? 0 : 30000,
    receiveTimeout: (kIsWeb) ? 0 : 30000,
  );
  static final Dio dio = Dio(options);
  static Future<Either<BaseError, T>> uploadFile<T>({
    required String url,
    required String fileKey,
    required List<File> file,
    Map<String, dynamic>? data,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
    required String strString,
  }) async {
    final Map<String, dynamic> dataMap = {};
    if (data != null) {
      dataMap.addAll(data);
    }
    final Map<String, dynamic> queryMap = {};
    if (queryParameters != null) {
      queryMap.addAll(queryParameters);
    }
    List<MultipartFile> multipartFiles = [];
    for (var element in file) {
      String fileName = element.path.split("/").last;
      multipartFiles.add(await MultipartFile.fromFile(element.path, filename: fileName));
    }
    dataMap.addAll({fileKey: multipartFiles, 'MnD': 'MnD'});

    try {
      final response = await dio.post(
        url,
        data: FormData.fromMap(dataMap),
        queryParameters: queryMap,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
      );

      // Get the decoded json
      var decodedJson;
      if (response.data is String) {
        decodedJson = json.decode(response.data);
      } else {
        decodedJson = response.data;
      }
      if (decodedJson['result'] == null) decodedJson['result'] = {'id': 0, 'file': ''};

      debugPrint('respooooooonse : $decodedJson');
      // Return the http response with actual data
      return Right(ModelsFactory.getInstance()!.createModel<T>(decodedJson, strString));
    }

    // Handling errors
    on DioError catch (e) {
      return Left(handleDioError(e));
    }

    // Couldn't reach out the server
    on SocketException catch (e, stacktrace) {
      print(e);
      print(stacktrace);
      return Left(const SocketError(message: ['please check your connection']));
    }
  }

  static Future<Either<BaseError, T>> sendObjectRequest<T>({
    required HttpMethod method,
    required String url,
    Map<String, dynamic>? data,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    required String strString,
  }) async {
    try {
      debugPrint('[$method: $url] data : [$data]');
      debugPrint('queryParameters : [$queryParameters]');

      dio.options.headers = headers;

      debugPrint(jsonEncode(data)); //CONVERT DATA TO STRING

      // Get the response from the server
      Response response;
      switch (method) {
        case HttpMethod.GET:
          response = await dio.get(
            url,
            queryParameters: queryParameters,
          );
          break;
        case HttpMethod.POST:
          response = await dio.post(
            url,
            data: data,
            queryParameters: queryParameters ?? {},
          );
          break;
        case HttpMethod.PUT:
          response = await dio.put(
            url,
            data: data,
            queryParameters: queryParameters,
          );
          break;
        case HttpMethod.DELETE:
          response = await dio.delete(
            url,
            data: data,
            queryParameters: queryParameters,
          );
          break;
      }

      // Get the decoded json
      var decodedJson;

      if (response.data is String) {
        debugPrint(response.toString());
        decodedJson = json.decode(response.data);
        debugPrint(decodedJson);
      } else {
        decodedJson = response.data;
      }

      if (decodedJson['result'] == false || decodedJson['result'] == true) decodedJson['result'] = {'': ''};
      if (kDebugMode) {
        printWrapped(decodedJson.toString());
      }

      if ((response.statusCode)! > 199 && (response.statusCode)! < 300) {
        if (decodedJson['success'] == true) {
          if (decodedJson['data'] != null) {
            return Right(ModelsFactory.getInstance()!.createModel<T>(decodedJson, strString));
          } else {
            return const Left(CustomError(
              errorMessage: ['Data Not Found'],
            ));
          }
        } else {
          return Left(CustomError(
            errorMessage: decodedJson['errors'],
          ));
        }
        // Return the http response with actual data

      } else {
        return Left(CustomError(
          errorMessage: decodedJson['errors'],
        ));
      }
    }

    // Handling errors
    on DioError catch (e) {
      print(e);
      return Left(handleDioError(e));
    }

    // Couldn't reach out the server
    on SocketException catch (e, stacktrace) {
      print(e);
      print(stacktrace);
      return const Left(SocketError(message: ['please check your connection']));
    }
  }

  static Future<Either<BaseError, bool>> sendObjectWithOutResponseRequest<T>({
    required HttpMethod method,
    required String url,
    Map<String, dynamic>? data,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    try {
      debugPrint('lllllllllllllllllllllllllllllllll$headers');
      debugPrint('[$method: $url] data : [$data]');
      debugPrint('queryParameters : [$queryParameters]');

      debugPrint(jsonEncode(data));

      dio.options.headers = headers;

      // Get the response from the server
      Response response;
      switch (method) {
        case HttpMethod.GET:
          response = await dio.get(
            url,
            queryParameters: queryParameters,
          );
          break;
        case HttpMethod.POST:
          response = await dio.post(
            url,
            data: data,
            queryParameters: queryParameters ?? {},
          );
          break;
        case HttpMethod.PUT:
          response = await dio.put(
            url,
            data: data,
            queryParameters: queryParameters,
          );
          break;
        case HttpMethod.DELETE:
          response = await dio.delete(
            url,
            data: data,
            queryParameters: queryParameters,
          );
          break;
      }

      // Get the decoded json
      var decodedJson;

      if (response.data is String) {
        decodedJson = json.decode(response.data);
      } else {
        decodedJson = response.data;
      }

      if (decodedJson['result'] == false || decodedJson['result'] == true) decodedJson['result'] = {'': ''};
      if (kDebugMode) {
        printWrapped(decodedJson.toString());
      }

      if ((response.statusCode)! > 199 && (response.statusCode)! < 300) {
        if (decodedJson['success'] == true) {
          return const Right(true);
        } else {
          return Left(CustomError(
            errorMessage: decodedJson['errors'],
          ));
        }
      }
      // Return the http response with actual data
      else {
        return Left(CustomError(
          errorMessage: decodedJson['errors'],
        ));
      }
    }

    // Handling errors
    on DioError catch (e) {
      print(e);
      return Left(handleDioError(e));
    }

    // Couldn't reach out the server
    on SocketException catch (e, stacktrace) {
      print(e);
      print(stacktrace);
      return const Left(SocketError(message: ['please check your connection']));
    }
  }

  static Future<Either<BaseError, T>> sendObjectWithResponseRequest<T>({
    required HttpMethod method,
    required String url,
    Map<String, dynamic>? data,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    try {
      debugPrint('headers $headers');
      debugPrint('[$method: $url] data : [$data]');
      debugPrint('queryParameters : [$queryParameters]');

      debugPrint(jsonEncode(data));

      dio.options.headers = headers;

      // Get the response from the server
      Response response;
      switch (method) {
        case HttpMethod.GET:
          response = await dio.get(
            url,
            queryParameters: queryParameters,
          );
          break;
        case HttpMethod.POST:
          response = await dio.post(
            url,
            data: data,
            queryParameters: queryParameters ?? {},
          );
          break;
        case HttpMethod.PUT:
          response = await dio.put(
            url,
            data: data,
            queryParameters: queryParameters,
          );
          break;
        case HttpMethod.DELETE:
          response = await dio.delete(
            url,
            data: data,
            queryParameters: queryParameters,
          );
          break;
      }

      // Get the decoded json
      var decodedJson;

      if (response.data is String) {
        decodedJson = json.decode(response.data);
      } else {
        decodedJson = response.data;
      }

      if (decodedJson['result'] == false || decodedJson['result'] == true) decodedJson['result'] = {'': ''};
      if (kDebugMode) {
        printWrapped(decodedJson.toString());
      }
      if ((response.statusCode)! > 199 && (response.statusCode)! < 300) {
        if (decodedJson['success'] == true) {
          return Right(decodedJson['data']);
        } else {
          return Left(CustomError(
            errorMessage: decodedJson['errors'],
          ));
        }
      }
      // Return the http response with actual data
      else {
        return Left(CustomError(
          errorMessage: decodedJson['errors'],
        ));
      }
    }

    // Handling errors
    on DioError catch (e) {
      print(e);
      return Left(handleDioError(e));
    }

    // Couldn't reach out the server
    on SocketException catch (e, stacktrace) {
      print(e);
      print(stacktrace);
      return Left(SocketError(message: ['please check your connection']));
    }
  }

  static void printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

  static BaseError handleDioError(DioError error) {
    if (kDebugMode) {
      print('error : $error');
    }
    if (error.type == DioErrorType.other || error.type == DioErrorType.response) {
      if (error is SocketException) return const SocketError(message: ['please check your connection']);
      if (error.type == DioErrorType.response) {
        switch (error.response!.statusCode) {
          case 400:
            debugPrint(error.response!.data['message'].toString());
            List<dynamic> errors = [];
            if (error.response!.data['message'] is String) {
              errors.add(error.response!.data['message']);
            } else {
              errors = error.response!.data['message'];
            }
            return BadRequestError(message: errors);
          case 401:
            //Keys.navigatorKey.currentContext.
            Navigation.goToLogin();
            return UnauthorizedError();
          case 403:
            return ForbiddenError();
          case 404:
            return NotFoundError(message: error.response!.data['message'], code: error.response!.data['code']);
          case 409:
            return ConflictError(message: error.response!.data['message'], code: error.response!.data['code']);
          case 500:
            debugPrint(error.response?.data);
            return InternalServerError();
          default:
            return HttpError(message: error.response!.data['message']);
        }
      }
      return const NetError(message: ['please check your connection']);
    } else if (error.type == DioErrorType.connectTimeout ||
        error.type == DioErrorType.sendTimeout ||
        error.type == DioErrorType.receiveTimeout) {
      return const TimeoutError(errorMessage: ['please check your connection']);
    } else if (error.type == DioErrorType.cancel) {
      return CancelError();
    } else {
      return UnknownError();
    }
  }
}
