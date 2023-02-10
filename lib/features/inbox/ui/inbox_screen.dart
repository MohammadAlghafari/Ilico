import 'dart:async';

import 'package:charja_charity/core/ui/dialogs/dialogs.dart';
import 'package:charja_charity/core/ui/widgets/loading.dart';
import 'package:collection/collection.dart' show IterableExtension;
import 'package:connectycube_sdk/connectycube_calls.dart';
import 'package:connectycube_sdk/connectycube_chat.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_icons.dart';
import '../../../core/ui/app_bar/app_bar_widget.dart';
import '../../../core/ui/widgets/Search_Text_filled.dart';
import '../../../core/utils/Navigation/Navigation.dart';
import '../../../core/utils/chat_util/chat_util.dart';
import '../widgets/chat_list_item.dart';
import 'chat_details_screen.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({Key? key, this.currentUser}) : super(key: key);

  final CubeUser? currentUser;

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  static const String TAG = "_BodyLayoutState";

  late List<ListItem<CubeDialog>> dialogList = [];
  var _isDialogContinues = true;

  StreamSubscription<CubeMessage>? msgSubscription;
  final ChatMessagesManager? chatMessagesManager = CubeChatConnection.instance.chatMessagesManager;

  TextEditingController? controller;
  bool showSearchField = false;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    if (chatMessagesManager != null) {
      msgSubscription = chatMessagesManager!.chatMessagesStream.listen(onReceiveMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(
        leadingWidget: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: SvgPicture.asset(
            logo_White,
          ),
        ),
        title: "Inbox".tr(),
        action: [
          InkWell(
            onTap: () {
              showSearchField = !showSearchField;
              setState(() {});
            },
            child: Padding(
              padding: EdgeInsets.only(right: 27.w),
              child: SvgPicture.asset(search),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          showSearchField
              ? Container(
                  // height: 50.h,
                  width: double.infinity,
                  padding: EdgeInsets.only(right: 27.w, left: 27.w, top: 10.h, bottom: 10.h),
                  color: Colors.white,
                  //margin: EdgeInsets.only(top: 100.h, bottom: 20.h),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 3,
                          blurRadius: 4,
                          offset: Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: SearchTextFilled(
                      isShowFilter: false,
                      hintText: 'Search'.tr(),
                      onTap: () {},
                      onChanged: (val) {
                        print(val);
                        _isDialogContinues = true;
                        setState(() {});
                      },
                      isSuffixIcon: false,
                      isPrefixIcon: true,
                      controller: controller,
                    ),
                  ))
              : SizedBox.shrink(),
          Visibility(
            visible: _isDialogContinues && dialogList.isEmpty,
            child: Container(
              margin: EdgeInsets.all(40),
              alignment: FractionalOffset.center,
              child: LoadingIndicator(),
            ),
          ),
          Expanded(child: _getDialogsList(context)),
        ],
      ),
    );
  }

  Widget _getDialogsList(BuildContext context) {
    if (chatMessagesManager == null) {
      return const Center(
        child: Text('Something went wrong, Pleas try later'),
      );
    }
    if (_isDialogContinues) {
      //Map<String, dynamic> additionalParams = {'full_name': controller?.text};
      getDialogs().then((dialogs) {
        _isDialogContinues = false;
        List<CubeDialog>? tempDialogs;
        log("getDialogs: $dialogs", TAG);
        setState(() {
          dialogList.clear();
          if (controller?.text != null && (controller?.text.isNotEmpty)!) {
            tempDialogs = dialogs?.items
                .where((element) => (element.name?.toLowerCase().contains((controller?.text.toLowerCase())!))!)!
                .toList();
          } else {
            tempDialogs = dialogs!.items;
          }

          dialogList.addAll(tempDialogs!.map((dialog) => ListItem(dialog)).toList());
        });
      }).catchError((exception) {
        _processGetDialogError(exception);
      });
    }
    if (_isDialogContinues && dialogList.isEmpty)
      return SizedBox.shrink();
    else if (dialogList.isEmpty)
      return Center(child: Text("No chats"));
    else
      return ListView.separated(
        itemCount: dialogList.length,
        itemBuilder: _getListItemTile,
        separatorBuilder: (context, index) {
          return Divider(thickness: 2, indent: 40, endIndent: 40);
        },
      );
  }

  Widget _getListItemTile(BuildContext context, int index) {
    return Container(
      child: ChatListItem(
        dialog: dialogList[index].data,
        onTap: () {
          _openDialog(context, dialogList[index].data);
        },
      ),
    );
  }

  void _openDialog(BuildContext context, CubeDialog? dialog) async {
    Navigation.push(ChatDetailsScreen(
      cubeDialog: dialog!,
    ))?.then((value) => refresh());
  }

  void refresh() {
    setState(() {
      _isDialogContinues = true;
    });
  }

  void _processGetDialogError(exception) {
    log("GetDialog error $exception", TAG);
    setState(() {
      _isDialogContinues = false;
    });
    Dialogs.showErrorSnackBar(
      message: exception.toString(),
    );
  }

  void onReceiveMessage(CubeMessage message) {
    log("onReceiveMessage global message= $message");
    updateDialog(message);
  }

  updateDialog(CubeMessage msg) {
    ListItem<CubeDialog>? dialogItem = dialogList.firstWhereOrNull((dlg) => dlg.data.dialogId == msg.dialogId);
    if (dialogItem == null) return;
    dialogItem.data.lastMessage = msg.body;
    setState(() {
      dialogItem.data.lastMessage = msg.body;
    });
  }

  @override
  void dispose() {
    super.dispose();
    msgSubscription?.cancel();
  }
}
