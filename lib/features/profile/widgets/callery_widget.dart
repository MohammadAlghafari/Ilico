import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:video_player/video_player.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/ui/widgets/cachedImage.dart';

class GalleryWidget extends StatefulWidget {
  const GalleryWidget({
    ValueKey? key,
    required this.image,
    required this.Type,
    required this.previewImage,
    required this.deleteImage,
    required this.imageType,
  }) : super(key: key);
  final String image;
  final int Type;
  final Function previewImage;
  final Function deleteImage;
  final String imageType;

  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  bool? isVisibil = true;

  // late File imageSelected;
  late VideoPlayerController _controller;
  bool _isPlaying = false;
  @override
  void initState() {
    // TODO: implement initState
    //imageSelected = widget.image;
    if (widget.Type == 2) {
      if (widget.imageType == "file") {
        _controller = VideoPlayerController.file(File(widget.image))
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
      } else if (widget.imageType == "network") {
        _controller = VideoPlayerController.network(widget.image)
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
    // TODO: implement dispose
    if (widget.Type == 2) {
      _controller.dispose();
    }
    //_controller=null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.kGreyLight),
        // width: 156.w,
        child: InkWell(
          onLongPress: () {
            setState(() {
              isVisibil = !isVisibil!;
            });
          },
          child: Visibility(
            visible: isVisibil!,
            replacement: Stack(
              fit: StackFit.expand,
              children: [
                widget.Type != 0
                    ? widget.Type == 1
                        ? widget.imageType == "network"
                            ? CachedImage(
                                imageUrl: widget.image,
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                File(widget.image),
                                fit: BoxFit.contain,
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
                        onTap: () {
                          widget.previewImage.call();
                          isVisibil = true;
                          setState(() {});
                        },
                      ),
                      InkWell(
                        child: SvgPicture.asset(delete),
                        onTap: () {
                          widget.deleteImage.call();
                          isVisibil = true;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
            child: widget.Type == 1
                ? widget.imageType == "network"
                    ? CachedImage(
                        imageUrl: widget.image,
                        fit: BoxFit.fill,
                      )
                    : Image.file(
                        File(widget.image),
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
                      )
                    : Container(),
          ),
        ));
  }
}
