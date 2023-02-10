import 'package:connectycube_sdk/connectycube_chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/ui/widgets/unicorn_outline_button.dart';

class ChatListItem extends StatefulWidget {
  const ChatListItem({Key? key, this.dialog, required this.onTap}) : super(key: key);

  final CubeDialog? dialog;
  final VoidCallback onTap;

  @override
  State<ChatListItem> createState() => _ChatListItemState();
}

class _ChatListItemState extends State<ChatListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.dialog!.unreadMessageCount! == 0 ? Colors.white : AppColors.kPOrangeColor.withOpacity(0.1),
      child: ListTile(
        onTap: widget.onTap,
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
          onPressed: () {},
          photoUrl: widget.dialog!.photo != null ? widget.dialog!.photo! : "",
          // child: widget.dialog!.photo != null
          //     ? CachedImage(
          //         imageUrl: widget.dialog!.photo ?? "assets/images/Rectangle.png",
          //         height: 50,
          //         width: 50,
          //         fit: BoxFit.cover,
          //       )
          //     : Image.asset(
          //         "assets/images/Rectangle.png",
          //         height: 50,
          //         width: 50,
          //         fit: BoxFit.cover,
          //       ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.dialog!.name ?? '',
              style: AppTheme.subtitle2.copyWith(
                fontSize: 14,
              ),
            ),
            widget.dialog!.unreadMessageCount! > 0
                ? Container(
                    height: 10.w,
                    width: 10.w,
                    decoration: BoxDecoration(
                      color: AppColors.kPOrangeColor,
                      shape: BoxShape.circle,
                      //border: Border.all(color: Colors.white, width: 3),
                    ),
                  )
                : SizedBox.shrink(),
          ],
        ),
        subtitle: Text(
            "${lastMessage}. $date"
            //"${widget.user!.lastMessage!} ${widget.user!.lastMessageDateSent}"
            ,
            style: AppTheme.subtitle2.copyWith(
              fontSize: 12,
              fontWeight: widget.dialog!.unreadMessageCount! == 0 ? FontWeight.w300 : FontWeight.w500,
            )),
      ),
    );
  }

  String get lastMessage {
    if (widget.dialog!.lastMessage == null) {
      return "";
    } else {
      return widget.dialog!.lastMessage!;
    }
  }

  String get date {
    if (widget.dialog!.lastMessageDateSent == null) {
      return '';
    }
    //return DateTime.fromMillisecondsSinceEpoch(widget.dialog!.lastMessageDateSent! * 1000).toString();
    return timeago.format(DateTime.fromMillisecondsSinceEpoch(widget.dialog!.lastMessageDateSent! * 1000));
  }
}
