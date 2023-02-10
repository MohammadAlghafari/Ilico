import 'package:charja_charity/core/boilerplate/get_model/widgets/get_model.dart';
import 'package:charja_charity/core/ui/widgets/loading.dart';
import 'package:charja_charity/core/utils/cashe_helper.dart';
import 'package:charja_charity/features/profile/data/profile_repository/profile_repository.dart';
import 'package:charja_charity/features/profile/data/queries.dart';
import 'package:charja_charity/features/profile/data/use_case/influncer_get_gallery_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/ui/widgets/cachedImage.dart';
import '../../../core/ui/widgets/no_data_widget.dart';
import '../data/model/SpMediaModel.dart';

class GalleryTabForInfluncer extends StatefulWidget {
  final String id;

  const GalleryTabForInfluncer({Key? key, required this.id}) : super(key: key);

  @override
  _GalleryTabForInfluncerState createState() => _GalleryTabForInfluncerState();
}

class _GalleryTabForInfluncerState extends State<GalleryTabForInfluncer> {
  // late PaginationCubit cubit;
  @override
  Widget build(BuildContext context) {
    return GetModel<SPGallery>(
      modelBuilder: ((model) {
        if (model.media!.isEmpty) {
          return const Center(child: NoDataWidget());
        }
        return Padding(
          padding: EdgeInsets.only(top: 25.0.h, right: 27.w, left: 27.w),
          child: GridView.builder(
            itemCount: model.media!.length,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 24, crossAxisSpacing: 24, childAspectRatio: 1),
            itemBuilder: (context, index) {
              return Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.kGreyLight),
                  child: CachedImage(
                    imageUrl: model.media![index].media!,
                    fit: BoxFit.cover,
                  ));
            },
          ),
        );
      }),
      loading: LoadingIndicator(),
      onSuccess: (SPGallery model) {},
      useCaseCallBack: () {
        if (CashHelper.authorized) {
          return InfluncerGetGalleryUseCase(ProfileRepository()).call(
              params: InfluncerGetGalleryParams(
            id: widget.id,
            query: getgalleryByInfluncerIdQueriesUser,
          ));
        } else {
          return InfluncerGetGalleryUseCase(ProfileRepository()).call(
              params: InfluncerGetGalleryParams(
            id: widget.id,
            query: getgalleryByInfluncerIdQueriesGuest,
          ));
        }
      },
    );
  }
}
