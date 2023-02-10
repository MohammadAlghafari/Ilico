import 'dart:convert';
import 'dart:io';

import 'package:charja_charity/core/http/graphQl_provider.dart';
import 'package:charja_charity/features/user_managment/data/model/login_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../constants/end_point.dart';
import '../errors/base_error.dart';
import '../errors/custom_error.dart';
import '../errors/socket_error.dart';
import '../http/api_provider.dart';
import '../http/http_method.dart';
import '../http/models_factory.dart';
import '../responses/ApiResponse.dart';
import '../utils/cashe_helper.dart';
import '../utils/date_helper.dart';
import 'model.dart';

abstract class RemoteDataSource {
  static Future<Either<BaseError, Data>> request<Data extends BaseModel, Response extends ApiResponse<Data>>({
    required String responseStr,
    required Response Function(Map<String, dynamic>) converter,
    required HttpMethod method,
    required String url,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    bool withAuthentication = false,
  }) async {
    ModelsFactory.getInstance()!.registerModel(responseStr, converter);
    final Map<String, String> headers = {};

    if (withAuthentication) {
      // await checkTokenValidation();
      final String token = CashHelper.getData(key: kACCESSTOKEN);
      debugPrint(token);
      headers.putIfAbsent(
          headerAuth, () => 'Bearer $token'); // authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9
    }

    final response = await ApiProvider.sendObjectRequest<Response>(
      method: method,
      url: url,
      headers: headers,
      queryParameters: queryParameters,
      data: data,
      strString: responseStr,
    );
    debugPrint(response.toString()); //instanceModel

    if (kDebugMode) {
      print('is right : ${response.isRight()}');
    }
    debugPrint('is right : ${response.isRight()}');
    if (response.isLeft()) {
      debugPrint('is left');
      return Left((response as Left<BaseError, Response>).value);
    } else {
      debugPrint('response right ${(response as Right<BaseError, Response>).value}');
      final resValue = response.value;
      return Right(resValue.data);
    }
  }

  static Future<Either<BaseError, bool>> noModelRequest({
    required HttpMethod method,
    required String url,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    bool withAuthentication = false,
  }) async {
    final Map<String, String> headers = {};

    if (withAuthentication) {
      //await checkTokenValidation();
      final String token = CashHelper.getData(key: kACCESSTOKEN);
      headers.putIfAbsent(headerAuth, () => 'Bearer $token');
    }

    final response = await ApiProvider.sendObjectWithOutResponseRequest(
      method: method,
      url: url,
      headers: headers,
      queryParameters: queryParameters,
      data: data,
    );

    if (kDebugMode) {
      print('is right : ${response.isRight()}');
    }
    debugPrint('is right : ${response.isRight()}');
    if (response.isLeft()) {
      debugPrint('is left');
      return Left((response as Left<BaseError, bool>).value);
    } else {
      debugPrint('response right ${(response as Right<BaseError, bool>).value}');
      final resValue = response;
      return resValue;
    }
  }

  static Future<Either<BaseError, T>> modelRequest<T>({
    required HttpMethod method,
    required String url,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    bool withAuthentication = false,
  }) async {
    final Map<String, String> headers = {};

    if (withAuthentication) {
      // await checkTokenValidation();
      final String token = CashHelper.getData(key: kACCESSTOKEN);
      headers.putIfAbsent(headerAuth, () => 'Bearer $token');
    }

    final response = await ApiProvider.sendObjectWithResponseRequest(
      method: method,
      url: url,
      headers: headers,
      queryParameters: queryParameters,
      data: data,
    );

    if (kDebugMode) {
      debugPrint('is right : ${response.isRight()}');
    }
    if (kDebugMode) {
      debugPrint('is right : ${response.isRight()}');
    }
    if (response.isLeft()) {
      debugPrint('is left');
      return Left((response as Left<BaseError, int>).value);
    } else {
      debugPrint('response right ${(response as Right<BaseError, T>).value}');
      final resValue = Right(response).value;
      return resValue;
    }
  }

  static Future<Either<BaseError, Data>> qlRequest<Data extends BaseModel>({
    required String responseStr,
    required Function(Map<String, dynamic>) converter,
    required QlMethod method,
    required String query,
    Map<String, dynamic>? params,
    required String modelKey,
    bool withAuthentication = false,
    bool withCash = true,
  }) async {
    ModelsFactory.getInstance()!.registerModel(responseStr, converter);
    print('with cash $withCash');
    var response = await GraphQlProvider.send<Data>(
        withCash: withCash,
        modelKey: modelKey,
        converter: converter,
        method: method,
        query: query,
        strString: responseStr,
        params: params);

    return Right(response).value;
  }

  static Future<Either<BaseError, void>?> checkTokenValidation() async {
    String? expireDate = CashHelper.getData(key: kAccessTOKENEXPIRATIONDATE);
    if (expireDate != null) {
      DateTime dateTime = DateHelper.convertStringDateToDateTime(expireDate);
      DateTime dateLocal = dateTime.toLocal();
      if (dateLocal.isBefore(DateTime.now())) {
        debugPrint('renew Token //////////////////////////////////////////////////////////////////////');
        Response? response;
        final Map<String, String> tempHeaders = {};
        final tempToken = await CashHelper.getData(key: kREFRESHTOKEN);
        print(tempToken);
        tempHeaders.putIfAbsent('refresh-token', () => '$tempToken');
        try {
          print(BASE_URL + refreshTokenURL);
          response = await Dio().get(
            BASE_URL + refreshTokenURL,
            options: Options(),
            queryParameters: tempHeaders,
          );
          if (response.statusCode == 200) {
            var decodedJson;
            if (response.data is String) {
              decodedJson = json.decode(response.data);
            } else {
              decodedJson = response.data;
            }
            LoginModel model = LoginModel.fromJson(decodedJson);
            print('New Token : ${model.accessToken}');
            CashHelper.saveData(key: kACCESSTOKEN, value: model.accessToken);
            CashHelper.saveData(key: kREFRESHTOKEN, value: model.refreshToken);
            CashHelper.saveData(key: kAccessTOKENEXPIRATIONDATE, value: model.accessTokenExpirationDate);
            CashHelper.saveData(key: REFRESHTOKENEXPIRATIONDATE, value: model.refreshTokenExpirationDate);
          }
        } on DioError catch (e) {
          print(e);
          return Left(ApiProvider.handleDioError(e));
        }

        // Couldn't reach out the server
        on SocketException catch (e, stacktrace) {
          print(e);
          print(stacktrace);
          return Left(SocketError(message: ['Something went wrong']));
        } catch (e) {
          print(e);
          return Left(CustomError(errorMessage: ['Something went wrong']));
        }
      }
    }
  }

  static Future<Either<BaseError, Data>> upload<Data>({
    required String responseStr,
    required Data Function(Map<String, dynamic>) converter,
    required String url,
    required String fileKey,
    required List<File> files,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool withAuthentication = false,
    CancelToken? cancelToken,
  }) async {
    ModelsFactory.getInstance()!.registerModel(responseStr, converter);
    final Map<String, String> headers = {};

    if (withAuthentication) {
      // await checkTokenValidation();
      final String token = CashHelper.getData(key: kACCESSTOKEN);

      debugPrint(token);
      headers.putIfAbsent(
          headerAuth, () => 'Bearer $token'); // authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9
    }

    final response = await ApiProvider.uploadFile<Data>(
        fileKey: fileKey,
        file: files,
        url: url,
        headers: headers,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
        strString: responseStr);

    print('is right : ${response.isRight()}');
    if (response.isLeft()) {
      print('is left');
      return Left((response as Left<BaseError, Data>).value);
    } else {
      print('response right ${(response as Right<BaseError, Data>).value}');
      final resValue = (response as Right<BaseError, Data>).value;

      return Right(resValue);
    }
  }
}
