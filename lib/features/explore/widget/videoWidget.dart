import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../core/constants/app_colors.dart';

class VideoWidget extends StatefulWidget {
  const VideoWidget({Key? key, required this.height, required this.width, required this.fit, required this.image})
      : super(key: key);
  final double height;
  final double width;
  final BoxFit fit;
  final File image;

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController _controller;
  @override
  void initState() {
    // TODO: implement initState

    // imageSelected = widget.image;

    _controller = VideoPlayerController.file(widget.image)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: _controller.value.isInitialized
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
            : Container(),
      ),
    );
  }
}
