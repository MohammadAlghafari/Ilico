import 'package:charja_charity/core/errors/http_error.dart';
import 'package:charja_charity/core/utils/cashe_helper.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../constants/end_point.dart';
import '../errors/base_error.dart';

class GraphQlProvider {
  static final ValueNotifier<GraphQLClient> _client =
      ValueNotifier(GraphQLClient(
    link: HttpLink(graphQlUrl),
    cache: GraphQLCache(store: HiveStore()),
  ));

  static Future<Either<BaseError, T>> send<T>({
    required QlMethod method,
    required String query,
    required String strString,
    required Function(Map<String, dynamic>) converter,
    Map<String, dynamic>? params,
  }) async {
    var options;

    switch (method) {
      case QlMethod.query:
        options = QueryOptions(
          document: gql(query),
          variables: params ?? {},
        );
        break;
      case QlMethod.mutations:
        options =
            MutationOptions(document: gql(query), variables: params ?? {});
        break;
      case QlMethod.subscriptions:
        options =
            SubscriptionOptions(document: gql(query), variables: params ?? {});
        break;
    }
    try {
      QueryResult result = await _client.value.query(options);
      if (result.hasException) {
        print(result.exception);
        if (result.exception!.graphqlErrors.isEmpty) {
          return const Left(HttpError(message: ["Internet is not found"]));
        } else {
          return Left(HttpError(message: result.exception!.graphqlErrors));
        }
      } else {
        print(result.data);

        return Right(converter(result.data!));
      }
    } catch (e) {
      print(e);
      return const Left(HttpError(message: ["Internet is not found"]));
    }
  }

  ///this function change the type of the link to auth link
  ///and must called after log in or register
  static void changeQlLink() {
    final AuthLink authLink = AuthLink(
      //getToken: () async => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
      getToken: () => 'Bearer ${CashHelper.getData(key: kACCESSTOKEN)}',
    );
    final Link link = authLink.concat(HttpLink(graphQlUrl));
    _client.value.copyWith(link: link);
  }
}

enum QlMethod { query, mutations, subscriptions }
