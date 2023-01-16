import 'package:charja_charity/core/boilerplate/pagination/widgets/pagination_list.dart';
import 'package:charja_charity/features/add_section/data/model/new_service.dart';
import 'package:charja_charity/features/profile/widgets/service_item.dart';
import 'package:flutter/cupertino.dart';

import '../data/model/get_product_model.dart';
import '../data/profile_repository/profile_repository.dart';
import '../data/use_case/get_product_usecase.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({Key? key}) : super(key: key);

  @override
  _ServicesScreenState createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  @override
  Widget build(BuildContext context) {
    return PaginationList<GetproductModel>(
      withPagination: true,
      repositoryCallBack: (model) {
        return GetProductUseCase(ProfileRepository())
            .call(params: GetProductParams(request: model, type: "getService"));
      },
      listBuilder: (list) {
        return ListView.builder(
            itemCount: list.length,
            itemBuilder: ((context, index) {
              return ServiceItem(
                description: list[index].description!,
                name: list[index].name!,
                image: list[index].images![0],
                price: list[index].price!,
                service: AddService(
                  images: list[index].images,
                  price: list[index].price,
                  categoryId: list[index].categoryId,
                  description: list[index].description,
                  name: list[index].name,
                ),
              );
            }));
      },
    );
  }
}
