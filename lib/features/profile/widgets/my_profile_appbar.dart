import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:connectycube_sdk/connectycube_chat.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/app_icons.dart';
import '../../../core/ui/dialogs/dialogs.dart';
import '../../../core/utils/Navigation/Navigation.dart';
import '../../../core/utils/cashe_helper.dart';
import '../../inbox/ui/chat_details_screen.dart';
import '../data/model/sp_general_information_model.dart';

class MyProfileAppBar extends StatefulWidget {
  const MyProfileAppBar({Key? key, required this.profileInfo}) : super(key: key);
  final SPGeneralInformationModel profileInfo;

  @override
  _MyProfileAppBarState createState() => _MyProfileAppBarState();
}

class _MyProfileAppBarState extends State<MyProfileAppBar> {
  static const String TAG = "_spProfileScreen";

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 5,
      child: Container(
        height: 60.h,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: SvgPicture.asset(phoneIcon),
              onPressed: () {
                setState(() {});
              },
            ),
            IconButton(
              icon: SvgPicture.asset(messageIcon),
              onPressed: () {
                if (CashHelper.authorized) {
                  if (widget.profileInfo.generalInformation!.chatUserModel != null) {
                    getDialogs().then((dialogs) {
                      late CubeDialog tempDialogs;
                      bool temp = false;
                      log("getDialogs: $dialogs", TAG);
                      for (var element in dialogs!.items) {
                        if (element.userId == chatUserId) {
                          temp = true;
                          tempDialogs = element;
                        }
                      }
                      if (temp) {
                        _openDialog(tempDialogs);
                      } else {
                        _createNewDialog(chatUserId);
                      }
                    }).catchError((exception) {
                      _processGetDialogError(exception);
                    });
                  }
                } else {
                  Dialogs.showErrorSnackBar(message: 'Please log in'.tr(), typeSnackBar: AnimatedSnackBarType.warning);
                }
              },
            ),
            IconButton(
              icon: SvgPicture.asset(globalIcon),
              onPressed: () {
                setState(() {});
              },
            ),
            IconButton(
              icon: SvgPicture.asset(gpsIcon),
              onPressed: () {
                setState(() {});
              },
            )
          ],
        ),
      ),
    );
  }

  get chatUserId => widget.profileInfo.generalInformation!.chatUserModel!.id;

  void _openDialog(CubeDialog? dialog) async {
    Navigation.push(ChatDetailsScreen(
      cubeDialog: dialog!,
    ));
  }

  void _createNewDialog(int id) {
    CubeDialog newDialog = CubeDialog(CubeDialogType.PRIVATE, occupantsIds: [id]);
    createDialog(newDialog).then((createdDialog) {
      Navigation.push(ChatDetailsScreen(
        cubeDialog: createdDialog,
      ));
    }).catchError((error) {
      _processGetDialogError(error);
    });
  }

  void _processGetDialogError(exception) {
    log("GetDialog error $exception", TAG);
    setState(() {});
    Dialogs.showErrorSnackBar(
      message: exception.toString(),
    );
  }
}
