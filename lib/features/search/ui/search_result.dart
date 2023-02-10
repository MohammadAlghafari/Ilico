import 'package:charja_charity/core/utils/cashe_helper.dart';
import 'package:charja_charity/features/search/ui/search_result_map.dart';
import 'package:charja_charity/features/search/ui/search_result_profile_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/boilerplate/pagination/cubits/pagination_cubit.dart';
import '../../../core/boilerplate/pagination/widgets/pagination_list.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/constants/end_point.dart';
import '../../../core/ui/app_bar/app_bar_widget.dart';
import '../data/model/search_model.dart';
import '../data/repository/search_repository.dart';
import '../data/usecase/search_usecase.dart';
import '../widget/no_data_search_widget.dart';

class SearchResult extends StatefulWidget {
  final String searchKey;
  final String search;
  final bool? isFav;
  final bool? isPre;

  final double to;
  const SearchResult({
    Key? key,
    required this.search,
    this.isPre,
    required this.to,
    this.isFav,
    required this.searchKey,
  }) : super(key: key);

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  bool isMap = true;
  bool showSearchField = false;
  late PaginationCubit cubit;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        appBar: AppBarWidget(
          backgroundColor: isMap ? Colors.transparent : Colors.white,
          title: "search".tr(),
          isCenterTitle: true,
          withBackButton: true,
          titleWidget: Image.asset(logoSearch, scale: 5),
          action: [
            InkWell(
              onTap: () {
                setState(() {
                  showSearchField = !showSearchField;
                });
              },
              child: SvgPicture.asset(
                search,
              ),
            ),
            isMap
                ? InkWell(
                    onTap: () {
                      setState(() {
                        isMap = !isMap;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: SvgPicture.asset(listIcon),
                    ),
                  )
                : InkWell(
                    onTap: () {
                      setState(() {
                        isMap = !isMap;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: SvgPicture.asset(mapIcon),
                    ),
                  ),
          ],
        ),
        body: PaginationList<SearchOfServiceProvider>(
          noDataWidget: NoResultDataWidget(
            showSearchField: showSearchField,
          ),
          repositoryCallBack: (model) {
            return SearchUseCase(SearchRepository()).call(
                params: SearchParams(
              isPremium: widget.isPre,
              isUser: CashHelper.authorized ? true : false,
              request: model,
              searchKey: widget.searchKey,
              search: widget.search, //461000cf-cc45-445b-af9a-023699684d5b
              longitude: CashHelper.getData(key: LONGITUDE),
              latitude: CashHelper.getData(key: LATITUDE),
              to: widget.to,
              isFavorite: widget.isFav,
            ));
          },
          onCubitCreated: (PaginationCubit paginationCubit) {
            cubit = paginationCubit;
            // widget.voidCallback!(cubit);
          },
          withPagination: true,
          listBuilder: (list) {
            if (isMap) {
              return SearchResultMap(
                type: widget.searchKey,
                showSearchField: showSearchField,
                searchResult: list,
              );
            } else {
              return SearchResultProfileList(
                type: widget.searchKey,
                searchResult: list,
                showSearchField: showSearchField,
              );
            }
          },
        ));
  }
}
