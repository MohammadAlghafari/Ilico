import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CollaborationsWidget extends StatelessWidget {
  const CollaborationsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 27.w, vertical: 24.h),
      child: GridView.builder(
          itemCount: 4,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, mainAxisSpacing: 24, crossAxisSpacing: 24, childAspectRatio: 1),
          itemBuilder: (context, index) {
            return Container(
              width: 96.w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  'assets/images/gallary.png',
                  fit: BoxFit.contain,
                ),
              ),
            );
          }),
    );
  }
}
