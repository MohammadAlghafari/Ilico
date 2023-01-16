import 'dart:io';

class FileTypeImageOrVideos {
  int? type; // 1 is image / 2 is video
  File? imageFile;
  FileTypeImageOrVideos({required this.type, required this.imageFile});
}
