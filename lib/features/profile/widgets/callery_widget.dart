import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GalleryWidget extends StatelessWidget {
  const GalleryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 27.w, vertical: 24.h),
      child: GridView.builder(
        itemCount: 4,
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 24, crossAxisSpacing: 24, childAspectRatio: 1),
        itemBuilder: (context, index) {
          return Container(
            color: Colors.blue,
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.red),
              // width: 156.w,
              child: Image.asset('assets/images/gallary.png'),
            ),
          );
        },
      ),
    );
  }
}
