import 'package:charja_charity/core/boilerplate/get_model/widgets/get_model.dart';
import 'package:charja_charity/core/ui/widgets/loading.dart';
import 'package:charja_charity/core/utils/cashe_helper.dart';
import 'package:charja_charity/features/profile/data/profile_repository/profile_repository.dart';
import 'package:charja_charity/features/profile/data/queries.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/end_point.dart';
import '../../../core/ui/widgets/cachedImage.dart';
import '../../../core/ui/widgets/no_data_widget.dart';
import '../data/model/SpMediaModel.dart';
import '../data/use_case/sp_get_gallery_usecase.dart';

class GalleryTabForServiceProvider extends StatefulWidget {
  final String id;

  const GalleryTabForServiceProvider({Key? key, required this.id}) : super(key: key);

  @override
  _GalleryTabForServiceProviderState createState() => _GalleryTabForServiceProviderState();
}

class _GalleryTabForServiceProviderState extends State<GalleryTabForServiceProvider> {
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
              return ClipRRect(
                borderRadius: BorderRadius.circular(5.r),
                child: Container(
                    // decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.kGreyLight),
                    child: CachedImage(
                  imageUrl: model.media![index].media!,
                  fit: BoxFit.cover,
                )),
              );
            },
          ),
        );
      }),
      loading: LoadingIndicator(),
      onSuccess: (SPGallery model) {},
      useCaseCallBack: () {
        if (CashHelper.authorized) {
          return SPGetGalleryUseCase(ProfileRepository()).call(
              params: SPGetGalleryParams(
            id: widget.id,
            query: getgalleryBySPIdQueriesUser,
            latitude: CashHelper.getData(key: LATITUDE),
            longitude: CashHelper.getData(key: LONGITUDE),
          ));
        } else {
          return SPGetGalleryUseCase(ProfileRepository()).call(
              params: SPGetGalleryParams(
            id: widget.id,
            query: getgalleryBySPIdQueriesGuest,
            latitude: CashHelper.getData(key: LATITUDE),
            longitude: CashHelper.getData(key: LONGITUDE),
          ));
        }
      },
    );
  }
}
