import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/ui/widgets/Search_Text_filled.dart';
import '../../../core/ui/widgets/view_profile_card.dart';
import '../../../core/utils/Navigation/Navigation.dart';
import '../data/model/search_model.dart';

class SearchResultProfileList extends StatefulWidget {
  final bool showSearchField;
  final List<SearchOfServiceProvider> searchResult;
  final String type;

  const SearchResultProfileList(
      {Key? key, required this.showSearchField, required this.type, required this.searchResult})
      : super(key: key);

  @override
  State<SearchResultProfileList> createState() => _SearchResultProfileListState();
}

class _SearchResultProfileListState extends State<SearchResultProfileList> with AutomaticKeepAliveClientMixin {
  TextEditingController? controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: widget.showSearchField ? 60.h : 0),
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.searchResult.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 27.w, vertical: 10.h),
                  child: ViewProfileCard(
                    type: widget.type,
                    searchOfServiceProvider: widget.searchResult[index],
                    isInfluencer: false,
                    withIcon: false,
                  ),
                );
              }),
        ),
        widget.showSearchField
            ? Container(
                // height: 50.h,
                padding: EdgeInsets.only(right: 27.w, left: 27.w, top: 10.h),
                color: Colors.transparent,
                margin: EdgeInsets.only(top: 100.h, bottom: 20.h),
                child: SearchTextFilled(
                  isShowFilter: false,
                  onTap: () {
                    Navigation.pop();
                  },
                  isSuffixIcon: true,
                  isPrefixIcon: true,
                  controller: controller,
                ))
            : const SizedBox(),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
