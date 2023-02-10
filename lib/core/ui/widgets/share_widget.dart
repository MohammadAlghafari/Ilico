import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/app_icons.dart';
import '../../utils/share.dart';

class ShareWidget extends StatelessWidget {
  const ShareWidget({Key? key, required this.id, required this.role, this.withPadding}) : super(key: key);

  final String id;
  final String role;
  final bool? withPadding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        share();
      },
      child: SvgPicture.asset(
        shareIcon,
      ),
    );
  }

  Future<void> share() async {
    await Share.share(id, role);
  }
}
