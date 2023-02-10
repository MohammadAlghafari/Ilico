import 'package:charja_charity/core/boilerplate/pagination/cubits/pagination_cubit.dart';
import 'package:charja_charity/features/add_section/data/model/new_service.dart';
import 'package:charja_charity/features/add_section/data/repository/add_section_repostory.dart';
import 'package:charja_charity/features/profile/data/model/profile_model.dart';
import 'package:flutter/material.dart';

import '../../../core/boilerplate/pagination/widgets/pagination_list.dart';
import '../../add_section/data/usecase/get_product_usecase.dart';
import '../widgets/service_item.dart';

class ProductScreen extends StatefulWidget {
  final List<Activities> activities;
  final ValueChanged valueChanged;
  const ProductScreen({Key? key, required this.activities, required this.valueChanged}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late PaginationCubit cubit;
  @override
  Widget build(BuildContext context) {
    return PaginationList<AddService>(
      onCubitCreated: (PaginationCubit cub) {
        cubit = cub;
        widget.valueChanged(cubit);
      },
      withPagination: true,
      repositoryCallBack: (model) {
        return GetProductUseCase(AddSectionRepostory())
            .call(params: GetProductParams(request: model, type: "getProduct"));
      },
      listBuilder: (list) {
        return ListView.builder(
            itemCount: list.length,
            itemBuilder: ((context, index) {
              return ServiceItem(
                cubit: cubit,
                type: 2,
                activites: widget.activities,
                description: list[index].description!,
                name: list[index].name!,
                image: list[index].images!.isNotEmpty ? list[index].images![0] : "",
                price: list[index].price!,
                service: AddService(
                  id: list[index].id,
                  images: list[index].images,
                  videos: list[index].videos,
                  price: list[index].price,
                  category: list[index].category,
                  description: list[index].description,
                  name: list[index].name,
                ),
              );
            }));
      },
    );
  }
}
