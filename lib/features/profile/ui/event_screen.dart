import 'package:charja_charity/core/boilerplate/pagination/cubits/pagination_cubit.dart';
import 'package:charja_charity/features/add_section/data/model/addEvent_model.dart';
import 'package:charja_charity/features/add_section/data/repository/add_section_repostory.dart';
import 'package:charja_charity/features/add_section/data/usecase/get_event_usecase.dart';
import 'package:flutter/material.dart';

import '../../../core/boilerplate/pagination/widgets/pagination_list.dart';
import '../data/model/profile_model.dart';
import '../widgets/service_item.dart';

class EventScreen extends StatefulWidget {
  final List<Activities> activities;
  final ValueChanged valueChanged;
  const EventScreen({Key? key, required this.activities, required this.valueChanged}) : super(key: key);

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  late PaginationCubit cubit;
  @override
  Widget build(BuildContext context) {
    return PaginationList<AddEventModel>(
      onCubitCreated: (PaginationCubit cub) {
        cubit = cub;
        widget.valueChanged(cubit);
      },
      withPagination: true,
      repositoryCallBack: (model) {
        return GetEventUseCase(AddSectionRepostory()).call(params: GetEventParams(request: model, type: "getEvent"));
      },
      listBuilder: (list) {
        return ListView.builder(
            itemCount: list.length,
            itemBuilder: ((context, index) {
              return ServiceItem(
                cubit: cubit,
                type: 3,
                activites: widget.activities,
                description: list[index].description!,
                name: list[index].name!,
                image: list[index].images!.isNotEmpty ? list[index].images![0] : " ",
                service: AddEventModel(
                  id: list[index].id,
                  images: list[index].images,
                  videos: list[index].videos,
                  description: list[index].description,
                  name: list[index].name,
                  startDate: list[index].startDate,
                  endDate: list[index].endDate,
                ),
              );
            }));
      },
    );
  }
}
