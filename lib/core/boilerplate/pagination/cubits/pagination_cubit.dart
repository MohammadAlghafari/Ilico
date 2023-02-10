import 'package:charja_charity/core/results/result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/get_list_request.dart';

part 'pagination_state.dart';

typedef RepositoryCallBack = Future<Result>? Function(dynamic data);

class PaginationCubit<ListModel> extends Cubit<PaginationState> {
  final RepositoryCallBack getData;

  PaginationCubit(this.getData) : super(PaginationInitial());
  List<ListModel> list = [];
  Map<String, dynamic> params = {};
  int limit = 10;
  int page = 1;
  String order = 'asc';

  getList({bool loadMore = false}) async {
    if (!loadMore) {
      page = 1;
      if (list.isEmpty) emit(Loading());
    } else {
      page++;
    }

    var requestData = GetListRequest(
      limit: limit,
      page: page,
      order: order,
    );
    var response = await getData(requestData);

    if (response == null) {
      emit(PaginationInitial());
    } else {
      if (response.hasDataOnly) {
        if (loadMore) {
          list.addAll(response.data as List<ListModel>);
        } else {
          list = response.data as List<ListModel>;
        }

        emit(GetListSuccessfully(
            list: list.toSet().toList(),
            noMoreData: (response.data.toSet().toList() as List<ListModel>).isEmpty && loadMore));
      } else if (response.hasErrorOnly) {
        if (response.error?.message?.first != null) {
          emit(Error(response.error?.message?.first!));
        }
        emit(Error('Some Thing went wrong'));
      } else {
        emit(PaginationInitial());
      }
    }
  }
}
