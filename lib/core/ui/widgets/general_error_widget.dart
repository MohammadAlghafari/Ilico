import 'package:charja_charity/core/ui/widgets/rounded_animated_button.dart';
import 'package:flutter/material.dart';

import '../../errors/error_helper.dart';
import '../../errors/unauthorized_error.dart';

class GeneralErrorWidget extends StatefulWidget {
  final VoidCallback? onTap;
  Widget? body;
  final error;
  final String? message;
  final String? buttonText;

  GeneralErrorWidget({
    Key? key,
    this.onTap,
    this.message,
    this.body,
    this.error,
    this.buttonText,
  }) : super(key: key);

  @override
  _GeneralErrorWidgetState createState() => _GeneralErrorWidgetState();
}

class _GeneralErrorWidgetState extends State<GeneralErrorWidget> {
  final errorHelper = ErrorHelper();

  @override
  void initState() {
    if (widget.error is UnauthorizedError) {
      /// TODO : Handle UnauthorizedError (toWorkOn)
    } else {
      widget.body = Center(
        child: Container(
          color: Colors.white,
          //child: Image.asset('assets/images/error.png'),
        ),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.error is UnauthorizedError) {
      /// TODO : Handle UnauthorizedError (toWorkOn)
    } else {
      widget.body = Center(
          //child: Image.asset('assets/images/error.png'),
          );
    }
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          widget.body ?? Container(),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              widget.message ?? errorHelper.getErrorMessage(widget.error),
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            child: RoundedAnimatedButton(
              //borderRadius: 15,
              onPressed: widget.onTap,
              text: widget.buttonText ?? 'Try Again',
              color: Colors.black,
              textStyle: const TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
