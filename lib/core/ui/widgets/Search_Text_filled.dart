import 'dart:async';

import 'package:charja_charity/core/constants/app_colors.dart';
import 'package:charja_charity/core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/app_styles.dart';

class SearchTextFilled extends StatefulWidget {
  const SearchTextFilled(
      {this.controller, this.isSuffixIcon = true, this.hintText, this.onChanged, this.isPrefixIcon = true});
  final TextEditingController? controller;
  final bool? isSuffixIcon;
  final Function(String)? onChanged;
  final bool? isPrefixIcon;
  final String? hintText;

  @override
  _SearchTextFilledState createState() => _SearchTextFilledState();
}

class _SearchTextFilledState extends State<SearchTextFilled> {
  Timer? _debounce;
  _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(seconds: 3), () {
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
      style: TextStyle(
        color: AppColors.kLightColor,
      ),
      keyboardType: TextInputType.text,
      autofocus: false,
      obscureText: false,
      onChanged: _onSearchChanged,
      controller: widget.controller,
      decoration: InputDecoration(
        errorMaxLines: 3,
        hintText: widget.hintText ?? "Search a service...",
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
                padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 12),
                child: SvgPicture.asset(
                  search,
                ),
              )
            : null,
        suffixIcon: widget.isSuffixIcon == true
            ? Padding(
                padding: const EdgeInsets.all(10.0),
                child: SvgPicture.asset(
                  filtterIcon,
                ),
              )
            : null,
      ),
    );
  }
}
