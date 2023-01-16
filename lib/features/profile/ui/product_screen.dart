import 'package:charja_charity/features/profile/data/model/get_product_model.dart';
import 'package:flutter/material.dart';

import '../../../core/boilerplate/pagination/widgets/pagination_list.dart';
import '../data/profile_repository/profile_repository.dart';
import '../data/use_case/get_product_usecase.dart';
import '../widgets/service_item.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return PaginationList<GetproductModel>(
      withPagination: true,
      repositoryCallBack: (model) {
        return GetProductUseCase(ProfileRepository())
            .call(params: GetProductParams(request: model, type: "getProduct"));
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
              );
            }));
      },
    );
  }
}
