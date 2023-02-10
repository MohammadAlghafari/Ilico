import 'package:charja_charity/core/boilerplate/get_model/widgets/get_model.dart';
import 'package:charja_charity/core/ui/widgets/loading.dart';
import 'package:charja_charity/core/utils/cashe_helper.dart';
import 'package:charja_charity/features/profile/data/model/SPEventModel.dart';
import 'package:charja_charity/features/profile/data/profile_repository/profile_repository.dart';
import 'package:charja_charity/features/profile/data/queries.dart';
import 'package:charja_charity/features/profile/data/use_case/sp_get_event_usecase.dart';
import 'package:charja_charity/features/profile/widgets/sp_article_item.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/constants/end_point.dart';
import '../../../core/ui/widgets/no_data_widget.dart';

class EventTabForServiceProvider extends StatefulWidget {
  final String id;

  const EventTabForServiceProvider({Key? key, required this.id}) : super(key: key);

  @override
  _EventTabForServiceProviderState createState() => _EventTabForServiceProviderState();
}

class _EventTabForServiceProviderState extends State<EventTabForServiceProvider> {
  // late PaginationCubit cubit;
  @override
  Widget build(BuildContext context) {
    return GetModel<SPEvent>(
      modelBuilder: ((model) {
        if (model.event!.isEmpty) {
          return const Center(child: NoDataWidget());
        }
        return ListView.builder(
            itemCount: model.event!.length,
            itemBuilder: ((context, index) {
              return SPArticleItem(
                isEvent: true,
                description: model.event![index].description!,
                name: model.event![index].name!,
                image: model.event![index].images!.isNotEmpty ? model.event![index].images![0] : "",
                date: model.event![index].startDate,
                // price: model.event![index].price!,
              );
            }));
      }),
      loading: LoadingIndicator(),
      onSuccess: (SPEvent model) {},
      useCaseCallBack: () {
        if (CashHelper.authorized) {
          return SPGetEventUseCase(ProfileRepository()).call(
              params: SPGetEventParams(
            id: widget.id,
            query: getEventByServiceProvideIdQueriesUser,
            latitude: CashHelper.getData(key: LATITUDE),
            longitude: CashHelper.getData(key: LONGITUDE),
          ));
        } else {
          return SPGetEventUseCase(ProfileRepository()).call(
              params: SPGetEventParams(
            id: widget.id,
            query: getEventByServiceProvideIdQueriesGuest,
            latitude: CashHelper.getData(key: LATITUDE),
            longitude: CashHelper.getData(key: LONGITUDE),
          ));
        }
      },
    );
  }
}
