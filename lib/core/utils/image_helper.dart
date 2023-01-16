import 'package:mime/mime.dart';

class ImageHelper {
  static bool isImage(String path) {
    final mimeType = lookupMimeType(path);

    return mimeType!.startsWith('image/');
  }

  static bool isVideo(String path) {
    final mimeType = lookupMimeType(path);

    return mimeType!.startsWith('video/');
  }
}
