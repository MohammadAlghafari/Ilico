import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoustomDialog extends StatelessWidget {
  const CoustomDialog({
    required this.context,
    required this.body,
    required this.actionButton,
  });
  final BuildContext context;
  final Widget? body;
  final Widget? actionButton;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0.r)),
      //title: Text(title!),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.0.w, vertical: 25.0.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [body!, Align(alignment: Alignment.bottomCenter, child: actionButton!)],
        ),
      ),
    );
  }
}

// class DialogUtils {
//   static void showCustomDialog(
//     BuildContext context, {
//     required Widget? body,
//     required Widget? actionButton,
//     required double? height,
//   }) {
//     showDialog(
//         context: Keys.navigatorKey.currentContext!,
//         builder: (_) {
//           return Dialog(
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20.0.r)),
//             //title: Text(title!),
//             child: Container(
//               height: height,
//               child: Padding(
//                 padding:
//                     EdgeInsets.symmetric(horizontal: 25.0.w, vertical: 25.0.h),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Expanded(child: body!),
//                     Align(
//                         alignment: Alignment.bottomCenter, child: actionButton!)
//                   ],
//                 ),
//               ),
//             ),
//           );
//         });
//   }
// }
