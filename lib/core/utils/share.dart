import 'package:flutter/foundation.dart';
import 'package:flutter_share/flutter_share.dart';

class Share {
  static Future<void> share(String id, String role) async {
    await FlutterShare.share(
      title: 'check out this profile',
      linkUrl: kDebugMode ? 'http://dev.illico1.com/profile/$role/$id' : 'http://qa.illico1.com/profile/$role/$id',
    );
  }
}
