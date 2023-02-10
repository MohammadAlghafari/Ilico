import 'package:charja_charity/core/boilerplate/get_model/widgets/get_model.dart';
import 'package:charja_charity/core/ui/widgets/loading.dart';
import 'package:charja_charity/core/ui/widgets/no_data_widget.dart';
import 'package:charja_charity/core/utils/cashe_helper.dart';
import 'package:charja_charity/features/add_section/data/model/new_service.dart';
import 'package:charja_charity/features/profile/data/model/SPServiceModel.dart';
import 'package:charja_charity/features/profile/data/profile_repository/profile_repository.dart';
import 'package:charja_charity/features/profile/data/queries.dart';
import 'package:charja_charity/features/profile/data/use_case/sp_get_services_usecase.dart';
import 'package:charja_charity/features/profile/widgets/service_item.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/constants/end_point.dart';

class ServicesTabForServiceProvider extends StatefulWidget {
  final String id;

  const ServicesTabForServiceProvider({Key? key, required this.id}) : super(key: key);

  @override
  _ServicesTabForServiceProviderState createState() => _ServicesTabForServiceProviderState();
}

class _ServicesTabForServiceProviderState extends State<ServicesTabForServiceProvider> {
  // late PaginationCubit cubit;
  @override
  Widget build(BuildContext context) {
    return GetModel<SPService>(
      modelBuilder: ((model) {
        if (model.services!.isEmpty) {
          return const Center(child: NoDataWidget());
        }
        return ListView.builder(
            itemCount: model.services!.length,
            itemBuilder: ((context, index) {
              return ServiceItem(
                canUpdate: false,
                // cubit: cubit,
                type: 1,
                // activites: widget.activities,
                description: model.services![index].description!,
                name: model.services![index].name!,
                image: model.services![index].images!.isNotEmpty ? model.services![index].images![0] : "",
                price: model.services![index].price!,
                service: AddService(
                  // id: model.services![index].id,
                  images: model.services![index].images,
                  videos: model.services![index].videos,
                  price: model.services![index].price,
                  //category: model.services![index].category,
                  description: model.services![index].description,
                  name: model.services![index].name,
                ),
              );
            }));
      }),
      loading: LoadingIndicator(),
      onSuccess: (SPService model) {},
      useCaseCallBack: () {
        if (CashHelper.authorized) {
          return SPGetServicesUseCase(ProfileRepository()).call(
              params: SPGetServicesParams(
            id: widget.id,
            query: getServiceByServiceProvideIdQueriesUser,
            latitude: CashHelper.getData(key: LATITUDE),
            longitude: CashHelper.getData(key: LONGITUDE),
          ));
        } else {
          return SPGetServicesUseCase(ProfileRepository()).call(
              params: SPGetServicesParams(
            id: widget.id,
            query: getServiceByServiceProvideIdQueriesGuest,
            latitude: CashHelper.getData(key: LATITUDE),
            longitude: CashHelper.getData(key: LONGITUDE),
          ));
        }
      },
    );
  }
}
