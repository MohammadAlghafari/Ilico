// import 'package:flutter/material.dart';
//
// import 'error_helper.dart';
//
// class GeneralErrorWidget extends StatefulWidget {
//   final VoidCallback? onTap;
//   Widget? body;
//   final error;
//   final String? message;
//
//   GeneralErrorWidget({
//     Key? key,
//     this.onTap,
//     this.message,
//     this.body,
//     this.error,
//   }) : super(key: key);
//
//   @override
//   _GeneralErrorWidgetState createState() => _GeneralErrorWidgetState();
// }
//
// class _GeneralErrorWidgetState extends State<GeneralErrorWidget> {
//   final errorHelper = ErrorHelper();
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//     // if (this.widget.error is UnauthorizedError) {
//     //   /// TODO : Handle UnauthorizedError (toWorkOn)
//     //   this.widget.body = SignInWidget();
//     // } else if (this.widget.error is InternalServerError) {
//     //   this.widget.body = Container(
//     //     width: ScreensHelper.fromWidth(75),
//     //     height: ScreensHelper.fromHeight(45),
//     //     child: Image.asset(
//     //       'assets/images/warning.png',
//     //       fit: BoxFit.contain,
//     //     ),
//     //   );
//     // } else {
//     //   this.widget.body = Container(
//     //     width: ScreensHelper.fromWidth(75),
//     //     height: ScreensHelper.fromHeight(45),
//     //     child: Image.asset(
//     //       'assets/images/no-wifi.png',
//     //       fit: BoxFit.contain,
//     //     ),
//     //   );
//     // }
//     // return Center(
//     //   child: Column(
//     //     children: <Widget>[
//     //       this.widget.body ?? Container(),
//     //       Padding(
//     //         padding: const EdgeInsets.all(12.0),
//     //         child: Text(
//     //           this.widget.message ??
//     //               errorHelper.getErrorMessage(this.widget.error),
//     //           style: TextStyle(
//     //             fontSize: 20,
//     //           ),
//     //           textAlign: TextAlign.center,
//     //         ),
//     //       ),
//     //       Container(
//     //         width: ScreensHelper.fromWidth(30),
//     //         child: ElevatedButton(
//     //           style: ButtonStyle(
//     //             backgroundColor:
//     //                 MaterialStateProperty.all(GlobalColors.primaryColor),
//     //           ),
//     //           onPressed: this.widget.callback,
//     //           child: Text(
//     //             'retry'.tr(),
//     //             style: TextStyle(
//     //               fontSize: 18,
//     //             ),
//     //           ),
//     //         ),
//     //       ),
//     //     ],
//     //   ),
//     // );
//   }
// }
