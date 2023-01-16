import 'package:charja_charity/core/boilerplate/create_model/widgets/create_model.dart';
import 'package:charja_charity/core/constants/app_icons.dart';
import 'package:charja_charity/core/ui/dialogs/app_dialog.dart';
import 'package:charja_charity/core/utils/Navigation/Navigation.dart';
import 'package:charja_charity/core/utils/extension/text_field_ext.dart';
import 'package:charja_charity/features/profile/data/model/profile_model.dart';
import 'package:charja_charity/features/profile/data/use_case/social_data_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/ui/widgets/Coustom_Button.dart';
import '../../../core/ui/widgets/custom_text_field.dart';
import '../../../core/utils/form_utils/form_state_mixin.dart';
import '../../profile/data/profile_repository/profile_repository.dart';
import '../ui/sign_up_upload_picture.dart';

class SocialMediaWidget extends StatefulWidget {
  SocialMediaWidget({Key? key, required this.btnName, this.model, required this.callback}) : super(key: key);
  final String? btnName;
  ProfileInfluencerModel? model;
  final ValueChanged callback;

  @override
  _SocialMediaWidgetState createState() => _SocialMediaWidgetState();
}

class _SocialMediaWidgetState extends State<SocialMediaWidget> with FormStateMinxin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        buildSingleRowItem([0, 1], [0, 1, 2], ["Facebook profile URL", "No. of followers"], ["https://", "0000"],
            url: widget.model?.facebookUrl, number: widget.model?.facebookFollowers),
        buildSingleRowItem([2, 3], [2, 3, 4], ["Instagram profile URL", "No. of followers"], ["https://", "0000"],
            url: widget.model?.instagramUrl, number: widget.model?.instagramFollowers),
        buildSingleRowItem([4, 5], [4, 5, 6], ["Tiktok profile URL", "No. of followers"], ["https://", "0000"],
            url: widget.model?.tiktokUrl, number: widget.model?.tiktokFollowers),
        buildSingleRowItem([6, 7], [6, 7, 8], ["Youtube profile URL", "No. of followers"], ["https://", "0000"],
            url: widget.model?.youtubeUrl, number: widget.model?.youtubeFollowers),
        buildSingleRowItem([8, 9], [8, 9, 10], ["Twitter profile URL", "No. of followers"], ["https://", "0000"],
            url: widget.model?.twitterUrl, number: widget.model?.twitterFollowers),
        buildSingleRowItem([10, 11], [10, 11], ["Snapchat profile URL", "No. of followers"], ["https://", "0000"],
            isEndText: true, url: widget.model?.snapchatUrl, number: widget.model?.snapchatFollowers),
        SizedBox(
          height: 20,
        ),
        CreateModel(
          onSuccess: (UserInfo model) {
            widget.model = model as ProfileInfluencerModel;
            widget.callback(model);
            print(model);
            showDialog(
              context: context,
              builder: (context) {
                return AppDialog(
                    isHaveCancel: false,
                    Confirm: "OK",
                    btnWidth: 114.w,
                    buildContext: context,
                    body: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(checkCircle),
                        ),
                        Text(
                          "Changes have been saved",
                          style: AppTheme.headline3
                              .copyWith(fontWeight: FontWeight.w500, color: AppColors.kPDarkBlueColor),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    function: () {
                      if (widget.btnName == 'Confirm') {
                        Navigation.push(SignUpUploadPicture());
                      } else {
                        FocusScope.of(context).unfocus();
                        Navigation.pop();
                      }
                    }).showDialog(context);
              },
            );
          },
          withValidation: false,
          useCaseCallBack: (model) {
            return SocialDataUseCase(ProfileRepository()).call(
                params: SocialDataParams(
                    facebookUrl: form.controllers[0].text,
                    facebookFollowers: getValue(form.controllers[1].text),
                    instagramUrl: form.controllers[2].text,
                    instagramFollowers: getValue(form.controllers[3].text),
                    tiktokUrl: form.controllers[4].text,
                    tiktokFollowers: getValue(form.controllers[5].text),
                    youtubeUrl: form.controllers[6].text,
                    youtubeFollowers: getValue(form.controllers[7].text),
                    twitterUrl: form.controllers[8].text,
                    twitterFollowers: getValue(form.controllers[9].text),
                    snapchatUrl: form.controllers[10].text,
                    snapchatFollowers: getValue(form.controllers[11].text))); //todo change value to from cache helper
          },
          child: Row(
            children: [
              Expanded(
                child: CoustomButton(
                  buttonName: widget.btnName,
                  backgoundColor: AppColors.kWhiteColor,
                  borderSideColor: AppColors.kPDarkBlueColor,
                  borderRadius: 10,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
      ],
    );
  }

  Widget buildSingleRowItem(List<int> controller, List<int> nodes, List<String> name, List<String> hint,
      {bool isEndText = false, String? url, int? number}) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: CustomTextField(
            labelText: name[0],
            labelStyle: AppTheme.bodyText2,
            hintText: hint[0],
            initialValue: url ?? "",
            textEditingController: form.controllers[controller[0]],
            focusNode: form.nodes[nodes[0]],
            nextFocusNode: form.nodes[nodes[1]],
            onChanged: (val) {
              setState(() {
                print("update");
              });
            },
            //  useObscure: useObscure,
          ),
        ),
        SizedBox(
          width: 8.w,
        ),
        !isEndText
            ? Expanded(
                flex: 3,
                child: CustomTextField(
                  labelText: name[1],
                  labelStyle: AppTheme.bodyText2,
                  hintText: hint[1],
                  initialValue: number != null && number > 0 ? (number).toString() : null,
                  textEditingController: form.controllers[controller[1]],
                  focusNode: form.nodes[nodes[1]],
                  nextFocusNode: form.nodes[nodes[2]],
                  keyboardType: TextInputType.number,
                  enabled: form.controllers[controller[0]].text.isNotEmpty || url != "" ? true : false,
                ),
              )
            : Expanded(
                flex: 3,
                child: CustomTextField(
                  labelText: name[1],
                  labelStyle: AppTheme.bodyText2,
                  hintText: hint[1],
                  textEditingController: form.controllers[controller[1]],
                  focusNode: form.nodes[nodes[1]],
                  initialValue: number != null && number > 0 ? (number).toString() : null,
                  keyboardType: TextInputType.number,
                  enabled: form.controllers[controller[0]].text.isNotEmpty || url != "" ? true : false,
                  //nextFocusNode: form.nodes[nodes[2]],
                ),
              ),
      ],
    );
  }

  getValue(var value) {
    try {
      return int.parse(value);
    } catch (e) {
      return 0;
    }
  }

  @override
  int numberOfFields() => 12;
}
