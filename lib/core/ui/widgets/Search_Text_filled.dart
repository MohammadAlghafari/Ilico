import 'dart:async';

import 'package:charja_charity/core/constants/app_colors.dart';
import 'package:charja_charity/core/constants/app_icons.dart';
import 'package:charja_charity/core/ui/widgets/sheet/coustom_sheet.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../features/search/widget/filter_search_sheet.dart';
import '../../constants/app_styles.dart';
import '../../utils/Navigation/Navigation.dart';

class SearchTextFilled extends StatefulWidget {
  const SearchTextFilled(
      {this.controller,
      this.isShowFilter,
      this.isPre,
      this.to,
      this.from,
      this.onFieldSubmitted,
      this.isSuffixIcon = true,
      this.isFavorite,
      this.hintText,
      this.onChanged,
      this.onTap,
      this.isPrefixIcon = true});
  final TextEditingController? controller;
  final bool? isSuffixIcon;
  final Function(String)? onChanged;
  final bool? isPrefixIcon;
  final String? hintText;
  final ValueChanged<String>? onFieldSubmitted;
  final ValueChanged<double>? from;
  final ValueChanged<double>? to;
  final ValueChanged<bool>? isFavorite;
  final ValueChanged<bool>? isPre;
  final GestureTapCallback? onTap;
  final bool? isShowFilter;

  @override
  _SearchTextFilledState createState() => _SearchTextFilledState();
}

class _SearchTextFilledState extends State<SearchTextFilled> {
  bool value1 = false;
  bool value2 = false;
  late double selectedValue1;
  late double selectedValue2;
  bool? isInitFav;
  bool? isInitPremium;
  late double tO = 5.0;
  Timer? _debounce;
  _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(Duration(seconds: 1), () {
      widget.onChanged!(query);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: widget.onTap,
      style: const TextStyle(
        color: Colors.black,
      ),
      keyboardType: TextInputType.text,
      autofocus: true,
      obscureText: false,
      onFieldSubmitted: widget.onFieldSubmitted,
      onChanged: _onSearchChanged,
      controller: widget.controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 9.0),
        errorMaxLines: 3,
        hintText: widget.hintText ?? "Search a service...".tr(),
        fillColor: AppColors.kWhiteColor,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0),
          borderSide: const BorderSide(color: AppColors.kMediumLightColor, width: 0.5),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.kMediumLightColor, width: 0.5),
          borderRadius: BorderRadius.circular(50.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.kMediumColor, width: 0.5),
          borderRadius: BorderRadius.circular(50.0),
        ),
        hintStyle: AppTheme.subtitle1.copyWith(color: AppColors.kGrayTextField, fontSize: 14),
        labelStyle: const TextStyle(color: AppColors.kGrayTextField, fontSize: 14),
        prefixIcon: widget.isPrefixIcon == true
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 10),
                child: SvgPicture.asset(
                  search,
                ),
              )
            : null,
        suffixIcon: widget.isSuffixIcon == true
            ? InkWell(
                onTap: () {
                  if (widget.isShowFilter!) {
                    CustomSheet.show(
                        isDismissible: false,
                        // title: "Verify Mobile Number".tr(),
                        context: context,
                        child: FilterSheet(
                          initPer: isInitPremium!,
                          isPremiumOnly: (val) {
                            widget.isPre!(val);
                            isInitPremium = val;
                            setState(() {});
                          },
                          initFav: isInitFav!,
                          initTo: tO,
                          isFavirate: (val) {
                            widget.isFavorite!(val);
                            isInitFav = val;
                            setState(() {});
                          },
                          value2: value2,
                          value1: value1,
                          lowerValue: (val) {
                            selectedValue1 = val;
                            widget.from!(val);
                          },
                          upperValue: (val2) {
                            selectedValue2 = val2;
                            widget.to!(val2);
                            tO = val2;
                            setState(() {});
                          },
                        ));
                  } else {
                    Navigation.pop();
                  }

                  // Navigation.push(const RootScreen());
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset(
                    filterIcon,
                    fit: BoxFit.cover,
                    height: 2,
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
