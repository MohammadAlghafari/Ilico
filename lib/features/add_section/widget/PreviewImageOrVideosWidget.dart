import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:video_player/video_player.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_icons.dart';

class PreviewImageOrVideosWidget extends StatefulWidget {
  PreviewImageOrVideosWidget({
    ValueKey? key,
    required this.image,
    required this.Type,
    required this.previewImage,
    required this.deleteImage,
  }) : super(key: key);

  final File image;
  final int Type;
  final Function previewImage;
  final Function deleteImage;

  @override
  State<PreviewImageOrVideosWidget> createState() => _PreviewImageOrVideosWidgetState();
}

class _PreviewImageOrVideosWidgetState extends State<PreviewImageOrVideosWidget> {
  bool? isVisibil = true;

  late VideoPlayerController _controller;

  @override
  void initState() {
    if (widget.Type == 2) {
      _controller = VideoPlayerController.file(widget.image)
        ..initialize().then((_) {
          setState(() {});
        });
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.image.path);
    return InkWell(
      onLongPress: () {
        setState(() {
          isVisibil = !isVisibil!;
        });
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 100.w,
          width: 100.w,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.kGreyWhite),
          child: Visibility(
            visible: isVisibil!,
            replacement: Stack(
              fit: StackFit.expand,
              children: [
                widget.Type != 0
                    ? widget.Type == 1
                        ? Image.file(
                            widget.image,
                            fit: BoxFit.fill,
                            // opacity: const AlwaysStoppedAnimation(.5),
                          )
                        : _controller.value.isInitialized
                            ? AspectRatio(
                                aspectRatio: _controller.value.aspectRatio,
                                child: VideoPlayer(_controller),
                              )
                            : Container()
                    : Container(),
                Container(
                  height: 100.w,
                  width: 100.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10), color: AppColors.kPDarkBlueColor.withOpacity(0.5)),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        child: SvgPicture.asset(preview),
                        onTap: () => widget.previewImage.call(),
                      ),
                      InkWell(
                        child: SvgPicture.asset(delete),
                        onTap: () {
                          widget.deleteImage.call();
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
            child: widget.Type != 0
                ? widget.Type == 1
                    ? Image.file(
                        widget.image,
                        fit: BoxFit.fill,
                        // opacity: const AlwaysStoppedAnimation(.5),
                      )
                    : _controller.value.isInitialized
                        ? Stack(
                            fit: StackFit.expand,
                            children: [
                              AspectRatio(
                                aspectRatio: _controller.value.aspectRatio,
                                child: VideoPlayer(_controller),
                              ),
                              InkWell(
                                onTap: () {
                                  if (_controller.value.isPlaying) {
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
                          )
                        : Container()
                : Container(),
          ),
        ),
      ),
    );
  }
}
