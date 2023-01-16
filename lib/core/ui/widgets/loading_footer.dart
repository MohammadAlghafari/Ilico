import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

var customFooter = CustomFooter(
  builder: (BuildContext? context, LoadStatus? mode) {
    Widget body;
    if (mode == LoadStatus.idle) {
      body = const Text("pull up load");
    } else if (mode == LoadStatus.loading) {
      body = const CupertinoActivityIndicator();
    } else if (mode == LoadStatus.failed) {
      body = const Text("Load Failed!");
    } else if (mode == LoadStatus.canLoading) {
      body = const Text("release to load more");
    } else {
      body = const Text("No more Data");
    }
    return SizedBox(
      height: 55.0,
      child: Center(child: body),
    );
  },
);
