import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../utils/cashe_helper.dart';
import 'cachedImage.dart';

class UnicornOutlineButton extends StatefulWidget {
  final _GradientPainter _painter;
  final String? _photoUrl;
  final VoidCallback? _callback;
  final double _radius;
  final double minWidth;
  final double minHeight;
  final bool? isInfluencer;
  Widget? child;
  final bool isMarker;
  bool? isSelecte;

  UnicornOutlineButton({
    double strokeWidth = 2,
    double radius = 200,
    Gradient? gradient,
    required String? photoUrl,
    this.isInfluencer,
    this.minHeight = 100,
    this.minWidth = 100,
    this.child,
    this.isMarker = false,
    this.isSelecte = false,
    VoidCallback? onPressed,
  })  : this._painter = _GradientPainter(
          strokeWidth: strokeWidth,
          radius: radius,
          gradient: LinearGradient(
            colors: isInfluencer != null
                ? isInfluencer
                    ? [AppColors.kPOrangeColor, AppColors.kPink]
                    : (!isMarker)
                        ? [
                            AppColors.kPDarkBlueColor,
                            AppColors.kSFlashyGreenColor,
                          ]
                        : [
                            Colors.transparent,
                            Colors.transparent,
                          ]
                : (CashHelper.getRole() == 'Influencer')
                    ? [AppColors.kPOrangeColor, AppColors.kPink]
                    : [
                        AppColors.kPDarkBlueColor,
                        AppColors.kSFlashyGreenColor,
                      ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        this._photoUrl = photoUrl,
        this._callback = onPressed,
        this._radius = radius;

  @override
  State<UnicornOutlineButton> createState() => _UnicornOutlineButtonState();
}

class _UnicornOutlineButtonState extends State<UnicornOutlineButton> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: widget._painter,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: widget._callback,
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(widget._radius),
            onTap: widget._callback,
            child: Container(
              constraints: BoxConstraints(minWidth: widget.minWidth, minHeight: widget.minHeight),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  widget.child != null
                      ? widget.child!
                      : widget._photoUrl != null
                          ? Padding(
                              padding: !widget.isMarker ? EdgeInsets.all(4.0) : EdgeInsets.zero,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: CachedImage(
                                    height: widget.minHeight,
                                    width: widget.minWidth,
                                    imageUrl: widget._photoUrl!,
                                    fit: BoxFit.cover,
                                    //  scale: 6,
                                  )),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Image.asset(
                                'assets/images/Rectangle.png',
                                height: widget.minHeight - 1,
                                width: widget.minWidth - 1,
                                fit: BoxFit.cover,
                              ),
                            ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _GradientPainter extends CustomPainter {
  final Paint _paint = Paint();
  final double radius;
  final double strokeWidth;
  final Gradient gradient;

  _GradientPainter({required double strokeWidth, required double radius, Gradient? gradient})
      : this.strokeWidth = strokeWidth,
        this.radius = radius,
        this.gradient = gradient!;

  @override
  void paint(Canvas canvas, Size size) {
    // create outer rectangle equals size
    Rect outerRect = Offset.zero & size;
    var outerRRect = RRect.fromRectAndRadius(outerRect, Radius.circular(radius));

    // create inner rectangle smaller by strokeWidth
    Rect innerRect =
        Rect.fromLTWH(strokeWidth, strokeWidth, size.width - strokeWidth * 2, size.height - strokeWidth * 2);
    var innerRRect = RRect.fromRectAndRadius(innerRect, Radius.circular(radius - strokeWidth));

    // apply gradient shader
    _paint.shader = gradient.createShader(outerRect);

    // create difference between outer and inner paths and draw it
    Path path1 = Path()..addRRect(outerRRect);
    Path path2 = Path()..addRRect(innerRRect);
    var path = Path.combine(PathOperation.difference, path1, path2);
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;
}
