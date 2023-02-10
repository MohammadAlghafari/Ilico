import 'package:charja_charity/core/boilerplate/get_model/widgets/get_model.dart';
import 'package:charja_charity/core/ui/widgets/view_profile_card.dart';
import 'package:charja_charity/features/profile/data/model/get_my_favorite_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/ui/widgets/card_influncer.dart';
import '../../../core/ui/widgets/no_data_widget.dart';
import '../data/profile_repository/profile_repository.dart';
import '../data/use_case/get_my_favorite_usecase.dart';

class FavoriteTypeWidget extends StatefulWidget {
  const FavoriteTypeWidget({Key? key, required this.type}) : super(key: key);

  final String type;

  @override
  State<FavoriteTypeWidget> createState() => _FavoriteTypeWidgetState();
}

class _FavoriteTypeWidgetState extends State<FavoriteTypeWidget> {
  @override
  Widget build(BuildContext context) {
    return GetModel(
      onSuccess: (GetMyFavoriteListModel list) {
        list.favorites?.forEach((element) {
          if (element.influencerModel != null) {
            element.influencerModel!.isFav = true;
          } else {
            element.serviceProvider!.isFav = true;
          }
        });
        setState(() {});
      },
      useCaseCallBack: () {
        return GetMyFavoriteUseCase(ProfileRepository()).call(params: GetMyFavoriteParams(type: widget.type));
      },
      modelBuilder: (GetMyFavoriteListModel result) {
        return (result.favorites?.isNotEmpty)!
            ? ListView.builder(
                itemCount: result.favorites?.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 27.w, vertical: 10.h),
                    child: widget.type == 'Influencer'
                        ? ProfilCardInfluncer(
                            profileInfluencer: result.favorites![index].influencerModel!,
                          )
                        : ViewProfileCard(
                            type: "Product",
                            isInfluencer: widget.type == 'Influencer',
                            searchOfServiceProvider: result.favorites![index].serviceProvider,
                          ),
                  );
                })
            : NoDataWidget();
      },
    );
  }
}
