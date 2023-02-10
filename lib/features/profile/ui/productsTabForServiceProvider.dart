import 'package:charja_charity/core/boilerplate/get_model/widgets/get_model.dart';
import 'package:charja_charity/core/ui/widgets/loading.dart';
import 'package:charja_charity/features/add_section/data/model/new_service.dart';
import 'package:charja_charity/features/profile/data/model/SPProductsModel.dart';
import 'package:charja_charity/features/profile/data/profile_repository/profile_repository.dart';
import 'package:charja_charity/features/profile/data/queries.dart';
import 'package:charja_charity/features/profile/data/use_case/sp_get_products_usecase.dart';
import 'package:charja_charity/features/profile/widgets/service_item.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/constants/end_point.dart';
import '../../../core/ui/widgets/no_data_widget.dart';
import '../../../core/utils/cashe_helper.dart';

class ProductsTabForServiceProvider extends StatefulWidget {
  final String id;

  const ProductsTabForServiceProvider({Key? key, required this.id}) : super(key: key);

  @override
  _ProductsTabForServiceProviderState createState() => _ProductsTabForServiceProviderState();
}

class _ProductsTabForServiceProviderState extends State<ProductsTabForServiceProvider> {
  // late PaginationCubit cubit;
  @override
  Widget build(BuildContext context) {
    return GetModel<SPProduct>(
      modelBuilder: ((model) {
        if (model.products!.isEmpty) {
          return const Center(child: NoDataWidget());
        }
        return ListView.builder(
            itemCount: model.products!.length,
            itemBuilder: ((context, index) {
              return ServiceItem(
                canUpdate: false,
                // cubit: cubit,
                type: 1,
                // activites: widget.activities,
                description: model.products![index].description!,
                name: model.products![index].name!,
                image: model.products![index].images!.isNotEmpty ? model.products![index].images![0] : "",
                price: model.products![index].price!,
                service: AddService(
                  // id: model.services![index].id,
                  images: model.products![index].images,
                  videos: model.products![index].videos,
                  price: model.products![index].price,
                  //category: model.services![index].category,
                  description: model.products![index].description,
                  name: model.products![index].name,
                ),
              );
            }));
      }),
      loading: LoadingIndicator(),
      onSuccess: (SPProduct model) {
        print("test");
      },
      useCaseCallBack: () {
        if (CashHelper.authorized) {
          return SPGetProductsUseCase(ProfileRepository()).call(
              params: SPGetProductsParams(
                  id: widget.id,
                  latitude: CashHelper.getData(key: LATITUDE),
                  longitude: CashHelper.getData(key: LONGITUDE),
                  query: getProductsByServiceProvideIdQueriesUser));
        } else {
          return SPGetProductsUseCase(ProfileRepository()).call(
              params: SPGetProductsParams(
                  id: widget.id,
                  latitude: CashHelper.getData(key: LATITUDE),
                  longitude: CashHelper.getData(key: LONGITUDE),
                  query: getProductsByServiceProvideIdQueriesGuest));
        }
      },
    );
  }
}
