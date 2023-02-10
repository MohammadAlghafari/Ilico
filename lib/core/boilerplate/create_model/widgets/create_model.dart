import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../ui/dialogs/dialogs.dart';
import '../../../ui/widgets/loading.dart';
import '../cubits/create_model_cubit.dart';

typedef CreatedCallback = void Function(CreateModelCubit cubit);
typedef ModelCreated<Model> = Function(Model model);

class CreateModel<Model> extends StatefulWidget {
  final ModelCreated<Model>? onSuccess;
  final double? loadingHeight;
  final UsecaseCallBack? useCaseCallBack;
  final CreatedCallback? onCubitCreated;
  final Widget child;
  final Function? onTap;
  final bool withValidation;
  final Function? onError;

  const CreateModel(
      {Key? key,
      this.useCaseCallBack,
      this.onTap,
      this.onCubitCreated,
      required this.child,
      this.onSuccess,
      required this.withValidation,
      this.loadingHeight,
      this.onError})
      : super(key: key);

  @override
  State<CreateModel<Model>> createState() => _GetModelState<Model>();
}

class _GetModelState<Model> extends State<CreateModel<Model>> {
  CreateModelCubit<Model>? cubit;

  @override
  void initState() {
    cubit = CreateModelCubit<Model>(widget.useCaseCallBack!);
    if (widget.onCubitCreated != null) {
      widget.onCubitCreated!(cubit!);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateModelCubit, CreateModelState>(
      bloc: cubit,
      builder: (context, state) {
        if (widget.onCubitCreated != null) {
          widget.onCubitCreated!(cubit!);
        }

        if (state is Loading) {
          return SizedBox(height: 50.h, child: const Center(child: LoadingIndicator()));
        } else {
          return InkWell(
              onTap: () {
                if (widget.withValidation!) {
                  var temp = widget.onTap!();
                  if (temp != null && temp == true) {
                    cubit?.createModel();
                  }
                } else {
                  cubit?.createModel();
                }
              },
              child: widget.child);
        }
      },
      listener: (context, state) {
        if (state is CreateModelSuccessfully) {
          if (widget.onSuccess != null) widget.onSuccess!(state.model);
        }
        if (state is Error) {
          if (widget.onError != null) {
            widget.onError!(state.error);
          } else {
            Dialogs.showSnackBar(message: state.message.toString(), typeSnackBar: AnimatedSnackBarType.error);
          }
        }
      },
    );
  }
}
