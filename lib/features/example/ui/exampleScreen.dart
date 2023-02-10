import 'package:charja_charity/core/boilerplate/create_model/widgets/create_model.dart';
import 'package:charja_charity/core/constants/app_styles.dart';
import 'package:charja_charity/core/utils/extension/text_field_ext.dart';
import 'package:charja_charity/core/utils/form_utils/form_state_mixin.dart';
import 'package:charja_charity/features/example/data/usecase/example_usecase.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/ui/widgets/Coustom_Button.dart';
import '../../../core/ui/widgets/custom_text_field.dart';
import '../../../core/utils/validators/base_validator.dart';
import '../../../core/utils/validators/password_validator.dart';
import '../../../core/utils/validators/required_validator.dart';
import '../data/repositoy/example_repo_imp.dart';

class ExampleScreen extends StatefulWidget {
  const ExampleScreen({Key? key}) : super(key: key);

  @override
  State<ExampleScreen> createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> with FormStateMinxin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:
          // body: PaginationList<ExampleItem>(
          //   listBuilder: (list) {
          //     return ListView.builder(
          //         itemCount: list.length,
          //         itemBuilder: (context, index) {
          //           return ListTile(
          //             title: Text(list[index].title!),
          //           );
          //         });
          //   },
          //   repositoryCallBack: (model) {
          //     return GetSubjectUseCase(ExampleRepository())
          //         .call(params: GetSubjectParams(request: model, filter: 'search'));
          //   },
          //   initialParam: const {"sort": ""},
          // ),
          CreateModel(
            withValidation: false,
        onSuccess: (valu) {
          print(valu);
        },
        useCaseCallBack: (model) {
          return GetExampleUseCase(ExampleRepository()).call(params: GetExampleParams());
        },
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 27.w),
                child: CoustomButton(
                  buttonName: "Sign in",
                  backgoundColor: AppColors.kWhiteColor,
                  borderSideColor: AppColors.kPDarkBlueColor,
                  borderRadius: 10.0.r,
                ),
              ),
            ),
          ],
        ),
      ),

      //     GetModel<ExampleModel>(
      //   useCaseCallBack: () {
      //     return GetExampleUseCase(ExampleRepository()).call(params: GetExampleParams(id: "3")); //cubit//API
      //   },
      //   modelBuilder: (ExampleModel model) {
      //     return buildWidget(Colors.red, 200);
      //   },
      //   onSuccess: (ExampleModel model) {
      //     if (kDebugMode) {
      //       print(model.data);
      //     }
      //   },
      // )
    );
  }

  Widget buildWidget(Color color, double width) {
    return ListView(
      children: [
        Form(
          key: form.key,
          child: CustomTextField(
            validator: (v) => BaseValidator.validateValue(
              context,
              form.controllers[0].text,
              [RequiredValidator(), PasswordValidator()],
            ),
            labelText: 'Email',
            labelStyle: AppTheme.bodyText2,
            hintText: 'Enter your email',
            textEditingController: form.controllers[0],
            focusNode: form.item3[0],
            // nextFocusNode: form.item3[1],
          ),
        ),
        InkWell(
          onTap: () {
            form.validate();
          },
          child: Text('validate'),
        )
      ],
    );
  }

  @override
  int numberOfFields() => 1;
}

/// class Builder extends DelegateBuilder {
///   @override
///   Widget build(BuildContext context, int index, bool active) {
///     return Text('TAB $index');
///   }
/// }

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: ConvexAppBar(
      items: [
        TabItem(icon: Icons.home, title: 'Home'),
        TabItem(icon: Icons.map, title: 'Discovery'),
        TabItem(icon: Icons.add, title: 'Add'),
        TabItem(icon: Icons.message, title: 'Message'),
        TabItem(icon: Icons.people, title: 'Profile'),
      ],
      onTap: (int i) => print('click index=$i'),
    ));
  }
}
