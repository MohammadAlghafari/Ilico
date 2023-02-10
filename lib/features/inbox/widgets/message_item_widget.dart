import 'package:charja_charity/core/ui/widgets/cachedImage.dart';
import 'package:charja_charity/core/utils/date_helper.dart';
import 'package:connectycube_sdk/connectycube_chat.dart';
import 'package:connectycube_sdk/connectycube_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/ui/widgets/unicorn_outline_button.dart';

class MessageItemWidget extends StatefulWidget {
  const MessageItemWidget({ValueKey? key, required this.isOnline, required this.message, required this.user})
      : super(key: key);

  final CubeMessage message;
  final CubeUser user;
  final bool isOnline;

  @override
  State<MessageItemWidget> createState() => _MessageItemWidgetState();
}

class _MessageItemWidgetState extends State<MessageItemWidget> with AutomaticKeepAliveClientMixin {
  String? photoUrl;
  late VideoPlayerController _controller =
      VideoPlayerController.network(getPrivateUrlForUid(widget.message.attachments!.first.uid)!);
  bool _isPlaying = false;
  @override
  void initState() {
    if (widget.message.attachments != null && widget.message.attachments!.isNotEmpty) {
      photoUrl = getPrivateUrlForUid(widget.message.attachments!.first.uid);
      print('photoUrl: $photoUrl ');
      if (!widget.message.attachments!.first.type!.contains('image')) {
        _controller = VideoPlayerController.network(photoUrl!)
          ..addListener(() {
            final bool isPlaying = _controller.value.isPlaying;
            if (isPlaying != _isPlaying) {
              setState(() {
                _isPlaying = isPlaying;
              });
            }
          })
          ..initialize().then((_) {
            // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
            setState(() {});
          });
      }
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: UnicornOutlineButton(
        isInfluencer: false,
        minHeight: 45,
        minWidth: 45,
        strokeWidth: 2,
        radius: 100,
        gradient: const LinearGradient(
          colors: [
            AppColors.kPDarkBlueColor,
            AppColors.kSFlashyGreenColor,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        // child: Image.asset(
        //   'assets/images/Rectangle.png',
        //   height: 50,
        //   width: 50,
        //   fit: BoxFit.cover,
        // ),
        onPressed: () {}, photoUrl: widget.user.avatar,
      ),
      title: Row(
        children: [
          Text(
            widget.user.fullName!,
            style: AppTheme.subtitle2.copyWith(
              fontSize: 14,
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Container(
            height: 9.w,
            width: 9.w,
            decoration: BoxDecoration(
              color: AppColors.kGrayIndicator,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 1),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            DateHelper.convertDateTimeToDisplay(DateTime.fromMillisecondsSinceEpoch(widget.message.dateSent! * 1000),
                format: 'HH:mm'),
            style: AppTheme.subtitle2.copyWith(
              fontSize: 14,
            ),
          ),
        ],
      ),
      isThreeLine: true,
      subtitle: widget.message.attachments?.isNotEmpty ?? false
          // Image
          ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              widget.message.attachments!.first.type!.contains('image')
                  ? CachedImage(imageUrl: photoUrl ?? '', fit: BoxFit.cover)
                  : _controller.value.isInitialized
                      ? Container(
                          height: 160.h,
                          width: 160.h,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              AspectRatio(
                                aspectRatio: _controller.value.aspectRatio,
                                child: VideoPlayer(_controller),
                              ),
                              InkWell(
                                onTap: () {
                                  if (_isPlaying) {
                                    _controller.pause();
                                  } else {
                                    _controller.play();
                                  }
                                  setState(() {});
                                },
                                child: Icon(
                                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                                  color: AppColors.kWhiteColor,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(
                          color: Colors.grey.withOpacity(0.3),
                          height: 160.h,
                          width: 160.h,
                        )
            ])
          : widget.message.body != null && widget.message.body!.isNotEmpty
              // Text
              ? Text(widget.message.body!,
                  style: AppTheme.subtitle2.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ))
              : Container(
                  padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                  width: 200.0,
                  child: Text(
                    "Empty",
                    style: AppTheme.subtitle1,
                  ),
                ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
