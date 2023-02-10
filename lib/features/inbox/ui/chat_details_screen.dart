import 'dart:async';
import 'dart:io';

import 'package:charja_charity/core/constants/app_icons.dart';
import 'package:charja_charity/core/constants/app_styles.dart';
import 'package:charja_charity/core/ui/app_bar/app_bar_widget.dart';
import 'package:charja_charity/core/ui/widgets/loading.dart';
import 'package:charja_charity/core/utils/cashe_helper.dart';
import 'package:charja_charity/core/utils/image_helper.dart';
import 'package:collection/collection.dart';
import 'package:connectycube_sdk/connectycube_chat.dart';
import 'package:connectycube_sdk/connectycube_sdk.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/end_point.dart';
import '../../../core/ui/dialogs/dialogs.dart';
import '../../../core/ui/widgets/image_and_name_widget.dart';
import '../../../core/utils/chat_util/chat_util.dart';
import '../widgets/message_item_widget.dart';

class ChatDetailsScreen extends StatefulWidget {
  const ChatDetailsScreen({Key? key, required this.cubeDialog}) : super(key: key);

  final CubeDialog cubeDialog;

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  final TextEditingController textEditingController = TextEditingController();

  late bool isLoading;
  final ScrollController listScrollController = ScrollController();
  bool isTyping = false;
  String userStatus = '';
  int lastPartSize = 0;
  final Map<int?, CubeUser?> _occupants = {};

  static const int typingTimeout = 700;
  static const int stopTypingTimeout = 2000;
  bool isOnline = false;

  int _sendIsTypingTime = DateTime.now().millisecondsSinceEpoch;
  Timer? _sendStopTypingTimer;
  //late StreamSubscription<ConnectivityResult> connectivityStateSubscription;

  StreamSubscription<CubeMessage>? msgSubscription;
  StreamSubscription<MessageStatus>? deliveredSubscription;
  StreamSubscription<MessageStatus>? readSubscription;
  StreamSubscription<TypingStatus>? typingSubscription;
  late final CubeDialog _cubeDialog;

  List<CubeMessage> listMessage = [];
  Timer? typingTimer;

  List<CubeMessage> _unreadMessages = [];
  List<CubeMessage> _unsentMessages = [];

  List<CubeMessage> oldMessages = [];

  @override
  void initState() {
    super.initState();
    _initCubeChat();
    isLoading = false;
    _cubeDialog = widget.cubeDialog;
    isLoading = false;
    listScrollController.addListener(onScrollChanged);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(
        titleSpacing: 0,
        isCenterTitle: false,
        action: [],
        titleWidget: ImageAndNameWidget(
          name: 'Spencer Smith',
          job: isOnline.toString(),
        ),
        withBackButton: true,
      ),
      body: Stack(
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Divider(),
              // List of messages
              buildListMessage(),
              //Typing content
              buildTyping(),
              // Input content
              const Divider(),
              buildInput(),
            ],
          ),

          // Loading
          buildLoading()
        ],
      ),
    );
  }

  Widget buildListMessage() {
    getWidgetMessages(listMessage) {
      return ListView.builder(
        padding: const EdgeInsets.all(10.0),
        itemBuilder: (context, index) => buildItem(index, listMessage[index]),
        itemCount: listMessage.length,
        reverse: true,
        controller: listScrollController,
      );
    }

    return Flexible(
      child: StreamBuilder<List<CubeMessage>>(
        stream: getMessagesList().asStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: LoadingIndicator());
          } else {
            listMessage = snapshot.data ?? [];
            return getWidgetMessages(listMessage);
          }
        },
      ),
    );
  }

  Future<List<CubeMessage>> getMessagesList() async {
    if (listMessage.isNotEmpty) return Future.value(listMessage);

    Completer<List<CubeMessage>> completer = Completer();
    List<CubeMessage>? messages;
    try {
      await Future.wait<void>([
        getMessagesByDate(0, false).then((loadedMessages) {
          isLoading = false;
          messages = loadedMessages;
        }),
        getAllUsersByIds(_cubeDialog.occupantsIds!.toSet()).then((result) =>
            _occupants.addAll(Map.fromIterable(result!.items, key: (item) => item.id, value: (item) => item)))
      ]);
      completer.complete(messages);
    } catch (error) {
      completer.completeError(error);
    }
    return completer.future;
  }

  Future<List<CubeMessage>> getMessagesByDate(int date, bool isLoadNew) async {
    var params = GetMessagesParameters();
    params.sorter = RequestSorter(SORT_DESC, '', 'date_sent');
    params.limit = messagesPerPage;
    params.filters = [RequestFilter('', 'date_sent', isLoadNew || date == 0 ? 'gt' : 'lt', date)];

    return getMessages(_cubeDialog.dialogId!, params.getRequestParameters())
        .then((result) {
          lastPartSize = result!.items.length;

          return result.items;
        })
        .whenComplete(() {})
        .catchError((onError) {});
  }

  Future<List<CubeMessage>> getMessagesBetweenDates(int startDate, int endDate) async {
    var params = GetMessagesParameters();
    params.sorter = RequestSorter(SORT_DESC, '', 'date_sent');
    params.limit = messagesPerPage;
    params.filters = [RequestFilter('', 'date_sent', 'gt', startDate), RequestFilter('', 'date_sent', 'lt', endDate)];

    return getMessages(_cubeDialog.dialogId!, params.getRequestParameters()).then((result) {
      return result!.items;
    });
  }

  buildItem(int index, CubeMessage message) {
    return MessageItemWidget(
      key: ValueKey(message.id),
      isOnline: isOnline,
      message: message,
      user: message.senderId == null ? _occupants[message.recipientId]! : _occupants[message.senderId]!,
    );
  }

  void sendIsTypingStatus() {
    var currentTime = DateTime.now().millisecondsSinceEpoch;
    var isTypingTimeout = currentTime - _sendIsTypingTime;
    if (isTypingTimeout >= typingTimeout) {
      _sendIsTypingTime = currentTime;
      _cubeDialog.sendIsTypingStatus();
      print('start typing ');
      _startStopTypingStatus();
    }
  }

  Widget buildTyping() {
    return Visibility(
      visible: isTyping,
      child: Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.all(16.0),
        child: Text(
          userStatus,
          style: const TextStyle(color: AppColors.kBlackColor),
        ),
      ),
    );
  }

  void _startStopTypingStatus() {
    _sendStopTypingTimer?.cancel();
    _sendStopTypingTimer = Timer(const Duration(milliseconds: stopTypingTimeout), () {
      _cubeDialog.sendStopTypingStatus();
      print('stop typing ');
    });
  }

  Widget buildInput() {
    return SizedBox(
      width: double.infinity,
      height: 72.h,
      // decoration: const BoxDecoration(border: Border(top: BorderSide(width: 0.5)), color: Colors.white),
      child: Row(
        children: <Widget>[
          // Button send image
          Padding(
            padding: EdgeInsets.fromLTRB(24.w, 0, 12.w, 0),
            child: InkWell(
              onTap: () {
                openGallery();
              },
              child: SvgPicture.asset(
                sendImage,
              ),
            ),
          ),

          // Edit text
          Flexible(
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.kLightColor,
                hintText: 'Type your message...',
                contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.kGreyLight),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.kGreyLight),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.kGreyLight),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              style: AppTheme.subtitle1.copyWith(fontSize: 16, color: AppColors.kGrayTextField),
              controller: textEditingController,
              onChanged: (text) {
                sendIsTypingStatus();
              },
            ),
          ),

          // Button send message
          Padding(
            padding: EdgeInsets.fromLTRB(12.w, 0, 24.w, 0),
            child: InkWell(
              onTap: () => onSendChatMessage(textEditingController.text),
              child: SvgPicture.asset(
                sendMessage,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _initCubeChat() {
    log("_initCubeChat");
    if (CubeChatConnection.instance.isAuthenticated()) {
      log("[_initCubeChat] isAuthenticated");
      _initChatListeners();
    } else {
      log("[_initCubeChat] not authenticated");
      CubeChatConnection.instance.connectionStateStream.listen((state) {
        log("[_initCubeChat] state $state");
        if (CubeChatConnectionState.Ready == state) {
          _initChatListeners();

          if (_unreadMessages.isNotEmpty) {
            _unreadMessages.forEach((cubeMessage) {
              _cubeDialog.readMessage(cubeMessage);
            });
            _unreadMessages.clear();
          }

          if (_unsentMessages.isNotEmpty) {
            _unsentMessages.forEach((cubeMessage) {
              _cubeDialog.sendMessage(cubeMessage);
            });

            _unsentMessages.clear();
          }
        }
      });
    }
  }

  _initChatListeners() {
    log("[_initChatListeners]");

    msgSubscription = CubeChatConnection.instance.chatMessagesManager!.chatMessagesStream.listen(onReceiveMessage);
    deliveredSubscription =
        CubeChatConnection.instance.messagesStatusesManager!.deliveredStream.listen(onDeliveredMessage);
    readSubscription = CubeChatConnection.instance.messagesStatusesManager!.readStream.listen(onReadMessage);
    typingSubscription = CubeChatConnection.instance.typingStatusesManager!.isTypingStream.listen(onTypingMessage);
    //onlineStatus = CubeChatConnection.instance.lastActivityManager?.lastActivityStream.listen(onStatusChange);
    // CubeChatConnection.instance.lastActivityManager?.lastActivityStream.listen((lastActivityEvent) {
    //   log("lastActivityEvent: userId = ${lastActivityEvent.userId}, seconds = ${lastActivityEvent.seconds}");
    //   if (lastActivityEvent.seconds < 2) {
    //     isOnline = true;
    //   } else {
    //     isOnline = false;
    //   }
    // });

    CubeChatConnection.instance.lastActivityManager?.subscribeToUserLastActivityStatus(
        widget.cubeDialog.occupantsIds!.firstWhere((element) => element != CashHelper.getData(key: chatUserId)),
        callback: (seconds) {
      print('from callBack $seconds');
      if (seconds < 30) {
        isOnline = true;
      } else {
        isOnline = false;
      }
    });
  }

  void onReceiveMessage(CubeMessage message) {
    log("onReceiveMessage message= $message");
    if (message.dialogId != _cubeDialog.dialogId || message.senderId == CashHelper.getData(key: chatUserId)) return;

    addMessageToListView(message);
    _cubeDialog.readMessage(message).then((voidResult) {
      log("onReceiveMessage read message");
    }).catchError((error) {});
  }

  void onDeliveredMessage(MessageStatus status) {
    log("onDeliveredMessage message= $status");
    updateReadDeliveredStatusMessage(status, false);
  }

  void onReadMessage(MessageStatus status) {
    log("onReadMessage message= ${status.messageId}");
    updateReadDeliveredStatusMessage(status, true);
  }

  void onTypingMessage(TypingStatus status) {
    log("TypingStatus message= ${status.userId}");
    if (status.userId == CashHelper.getData(key: chatUserId) ||
        (status.dialogId != null && status.dialogId != _cubeDialog.dialogId)) return;
    userStatus = _occupants[status.userId]?.fullName ?? _occupants[status.userId]?.login ?? '';
    if (userStatus.isEmpty) return;
    userStatus = "$userStatus is typing ...";

    if (isTyping != true) {
      setState(() {
        isTyping = true;
      });
    }
    startTypingTimer();
  }

  updateReadDeliveredStatusMessage(MessageStatus status, bool isRead) {
    log('[updateReadDeliveredStatusMessage]');
    setState(() {
      CubeMessage? msg = listMessage.firstWhereOrNull((msg) => msg.messageId == status.messageId);
      if (msg == null) return;
      if (isRead) {
        msg.readIds == null ? msg.readIds = [status.userId] : msg.readIds?.add(status.userId);
      } else {
        msg.deliveredIds == null ? msg.deliveredIds = [status.userId] : msg.deliveredIds?.add(status.userId);
      }

      log('[updateReadDeliveredStatusMessage] status updated for $msg');
    });
  }

  startTypingTimer() {
    typingTimer?.cancel();
    typingTimer = Timer(Duration(milliseconds: 900), () {
      setState(() {
        isTyping = false;
      });
    });
  }

  /// for send message
  void onSendChatMessage(String content) {
    if (content.trim() != '') {
      final message = createCubeMsg();
      message.body = content.trim();
      onSendMessage(message);
    } else {
      Dialogs.showSnackBar(message: 'Nothing to send');
    }
  }

  void onSendMessage(CubeMessage message) async {
    log("onSendMessage message= $message");
    textEditingController.clear();
    await _cubeDialog.sendMessage(message);
    message.senderId = CashHelper.getData(key: chatUserId);
    addMessageToListView(message);
    listScrollController.animateTo(0.0, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  addMessageToListView(CubeMessage message) {
    isLoading = false;
    int existMessageIndex = listMessage.indexWhere((cubeMessage) {
      return cubeMessage.messageId == message.messageId;
    });

    if (existMessageIndex != -1) {
      listMessage[existMessageIndex] = message;
    } else {
      listMessage.insert(0, message);
    }
    setState(() {});
  }

  CubeMessage createCubeMsg() {
    var message = CubeMessage();
    message.dateSent = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    message.markable = true;
    message.saveToHistory = true;
    return message;
  }

  void openGallery() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result == null) return;

    setState(() {
      isLoading = true;
    });

    var uploadImageFuture = getUploadingImageFuture(result);
    var decodedImage;
    if (!ImageHelper.isVideo(result.files.single.path!)) {
      var imageData;

      if (kIsWeb) {
        imageData = result.files.single.bytes!;
      } else {
        imageData = File(result.files.single.path!).readAsBytesSync();
      }

      decodedImage = await decodeImageFromList(imageData);
    }

    uploadImageFile(uploadImageFuture, decodedImage);
  }

  Future uploadImageFile(Future<CubeFile> uploadAction, imageData) async {
    uploadAction.then((cubeFile) {
      onSendChatAttachment(cubeFile, imageData);
    }).catchError((ex) {
      setState(() {
        isLoading = false;
      });
      Dialogs.showSnackBar(message: 'This file is not an image');
    });
  }

  void onSendChatAttachment(CubeFile cubeFile, imageData) async {
    final attachment = CubeAttachment();
    attachment.id = cubeFile.uid;
    attachment.uid = cubeFile.uid;
    attachment.type = cubeFile.contentType;
    attachment.url = cubeFile.getPublicUrl();
    if (cubeFile.contentType!.contains('image')) {
      attachment.height = imageData.height;
      attachment.width = imageData.width;
    }
    final message = createCubeMsg();
    message.body = "Attachment";
    message.attachments = [attachment];
    onSendMessage(message);
  }

  Widget buildLoading() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: isLoading
          ? Padding(
              padding: EdgeInsets.only(bottom: 78.h),
              child: const LoadingIndicator(),
            )
          : Container(),
    );
  }

  void onScrollChanged() {
    if ((listScrollController.position.pixels == listScrollController.position.maxScrollExtent) &&
        messagesPerPage >= lastPartSize) {
      setState(() {
        isLoading = true;

        if (oldMessages.isNotEmpty) {
          getMessagesBetweenDates(oldMessages.first.dateSent ?? 0,
                  listMessage.last.dateSent ?? DateTime.now().millisecondsSinceEpoch ~/ 1000)
              .then((newMessages) {
            setState(() {
              isLoading = false;

              listMessage.addAll(newMessages);

              if (newMessages.length < messagesPerPage) {
                oldMessages.insertAll(0, listMessage);
                listMessage = List.from(oldMessages);
                oldMessages.clear();
              }
            });
          });
        } else {
          getMessagesByDate(listMessage.last.dateSent ?? 0, false).then((messages) {
            setState(() {
              isLoading = false;
              listMessage.addAll(messages);
            });
          });
        }
      });
    }
  }
}
