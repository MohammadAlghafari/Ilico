import 'dart:async';

import 'package:charja_charity/core/constants/app_styles.dart';
import 'package:charja_charity/core/constants/end_point.dart';
import 'package:charja_charity/core/utils/Navigation/Navigation.dart';
import 'package:charja_charity/features/search/ui/search_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/boilerplate/pagination/cubits/pagination_cubit.dart';
import '../../../core/boilerplate/pagination/widgets/pagination_list.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/ui/app_bar/app_bar_widget.dart';
import '../../../core/ui/widgets/Search_Text_filled.dart';
import '../../../core/utils/cashe_helper.dart';
import '../data/model/auto_complete_model.dart';
import '../data/repository/search_repository.dart';
import '../data/usecase/auto_complete_usecase.dart';

class SearchListViewScreen extends StatefulWidget {
  const SearchListViewScreen({Key? key, this.voidCallback, this.type}) : super(key: key);
  final ValueChanged? voidCallback;
  final String? type;

  @override
  _SearchListViewScreenState createState() => _SearchListViewScreenState();
}

class _SearchListViewScreenState extends State<SearchListViewScreen> {
  Timer? debounce;
  TextEditingController controller = TextEditingController();
  late PaginationCubit cubit;
  double to = 5.0;
  double from = 0.0;
  bool? isFaviroute;
  bool? isPer;
  @override
  Widget build(BuildContext context) {
    print(widget.type);
    return Scaffold(
        backgroundColor: AppColors.kLightColor,
        appBar: AppBarWidget(
          appBarHeight: 70,
          backgroundColor: Colors.white,
          // title: "search",
          isCenterTitle: true,
          withBackButton: true,
          titleWidget: Image.asset(logoSearch, scale: 5), action: [],
        ),
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.grey,
            //     spreadRadius: 5,
            //     blurRadius: 8,
            //     offset: Offset(3.0, 0),
            //   ),
            // ],
          ),
          child: Column(children: [
            Divider(
              height: 2,
              color: Colors.grey[250]?.withOpacity(0.1),
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 27.w),
                child: SearchTextFilled(
                  isPre: (val) {
                    isPer = val;
                    setState(() {});
                  },
                  isFavorite: (val) {
                    isFaviroute = val;
                    setState(() {});
                  },
                  isShowFilter: true,
                  from: (val) {
                    from = val;
                    setState(() {});
                  },
                  to: (val2) {
                    to = val2;
                    setState(() {});
                  },
                  onFieldSubmitted: (input) {
                    Navigation.push(SearchResult(
                      isPre: isPer,
                      isFav: isFaviroute,
                      to: to,
                      search: controller.text,
                      searchKey: widget.type!,
                    ));
                    print('onFieldSubmitted: $input');
                  },
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      cubit.getList();
                    }
                  },
                  isSuffixIcon: true,
                  isPrefixIcon: true,
                  controller: controller,
                ),
              ),
            ),
            Expanded(
              child: PaginationList<AutoCompleteSearchItem>(
                  onCubitCreated: (PaginationCubit paginationCubit) {
                    cubit = paginationCubit;
                    // widget.voidCallback!(cubit);
                  },
                  withPagination: true,
                  repositoryCallBack: (model) {
                    if (controller.text.isNotEmpty) {
                      return AutoCompleteSearchUseCase(SearchRepository()).call(
                          params: AutoCompleteSearchParams(
                        request: model,
                        type: widget.type,
                        search: controller.text,
                        latitude: CashHelper.getData(key: LATITUDE).toString(),
                        longitude: CashHelper.getData(key: LONGITUDE).toString(),
                      ));
                    }
                  },
                  listBuilder: (list) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: ListView.builder(
                          itemCount: list.length,
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {
                                Navigation.push(SearchResult(
                                  isPre: isPer,
                                  isFav: isFaviroute,
                                  to: to,
                                  search: list[index].name!,
                                  searchKey: widget.type!,
                                ));
                              },
                              leading: Image.asset(search_pin),
                              title: Text(
                                list[index].name!,
                                style: AppTheme.headline5,
                              ),
                            );
                          }),
                    );
                  }),
            )
          ]),
        ));
  }
}
