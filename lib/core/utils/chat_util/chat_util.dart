import 'dart:io';

import 'package:connectycube_sdk/connectycube_sdk.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:mime/mime.dart';

class ListItem<T> {
  bool isSelected = false; //Selection property to highlight or not
  T data; //Data of the user
  ListItem(this.data); //Constructor to assign the data
}

Future<CubeFile> getUploadingImageFuture(FilePickerResult result) async {
  // there possible to upload the file as an array of bytes, but here showed two ways just as an example
  if (kIsWeb) {
    return uploadRawFile(
        result.files.single.bytes!,
        mimeType: lookupMimeType(result.files.single.path!),
        result.files.single.name,
        isPublic: true, onProgress: (progress) {
      log("uploadImageFile progress= $progress");
    });
  } else {
    return uploadFile(File(result.files.single.path!),
        mimeType: lookupMimeType(result.files.single.path!), isPublic: true, onProgress: (progress) {
      log("uploadImageFile progress= $progress");
    });
  }
}
