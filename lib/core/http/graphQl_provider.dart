import 'dart:convert';

import 'package:charja_charity/core/errors/http_error.dart';
import 'package:charja_charity/core/utils/cashe_helper.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../constants/end_point.dart';
import '../errors/base_error.dart';

class GraphQlProvider {
  static ValueNotifier<GraphQLClient> _client = ValueNotifier(GraphQLClient(
    link: HttpLink(graphQlUrl),
    cache: GraphQLCache(store: HiveStore()),
  ));

  static Future<Either<BaseError, T>> send<T>({
    required QlMethod method,
    required String query,
    required String strString,
    required String modelKey,
    required Function(Map<String, dynamic>) converter,
    Map<String, dynamic>? params,
    bool withCash = true,
  }) async {
    var options;
    QueryResult result;
    debugPrint(CashHelper.getData(key: kACCESSTOKEN));
    debugPrint("[[[query type: $method ]]]");
    var dequdedQuery = jsonEncode(params);
    debugPrint("query: $query");
    debugPrint('params: ');
    debugPrint(dequdedQuery);
    try {
      switch (method) {
        case QlMethod.query:
          options = QueryOptions(
              document: gql(query),
              variables: params ?? {},
              fetchPolicy: withCash ? FetchPolicy.cacheAndNetwork : FetchPolicy.networkOnly);
          result = await _client.value.query(options);
          break;
        case QlMethod.mutations:
          options = MutationOptions(document: gql(query), variables: params ?? {});
          result = await _client.value.mutate(options);
          break;
        case QlMethod.subscriptions:
          options = SubscriptionOptions(document: gql(query), variables: params ?? {});
          result = await _client.value.query(options);
          break;
      }

      if (result.hasException) {
        debugPrint("--------Error--------");
        print(result.exception);
        if (result.exception!.graphqlErrors.isEmpty) {
          return const Left(HttpError(message: ["Internet is not found"]));
        } else {
          return Left(HttpError(message: [result.exception!.graphqlErrors.first.message]));
        }
      } else {
        debugPrint("--------Begin of Data--------");
        print(result.data);
        debugPrint("--------End of Data--------");
        if (modelKey.isNotEmpty) {
          return Right(converter(result.data![modelKey]));
        } else {
          return Right(converter(result.data!));
        }
      }
    } catch (e) {
      debugPrint("--------Error--------");
      print(e);
      return const Left(HttpError(message: ["Internet is not found"]));
    }
  }

  ///this function change the type of the link to auth link
  ///and must called after log in or register
  static void setQlLink({required auth}) {
    late final Link link;
    if (auth) {
      final AuthLink authLink = AuthLink(
        //getToken: () async => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
        getToken: () => 'Bearer ${CashHelper.getData(key: kACCESSTOKEN)}',
      );
      link = authLink.concat(HttpLink(graphQlUrl));
    } else {
      link = HttpLink(graphQlUrl);
    }
    _client = ValueNotifier(_client.value.copyWith(link: link));
  }
}

enum QlMethod { query, mutations, subscriptions }
