import 'dart:io';

class FileModel {
  String fileType;
  String filePath;
  File fileThumbnail;
  File fileMain;
  int? index;

  FileModel({
    required this.fileType,
    required this.filePath,
    required this.fileMain,
    required this.fileThumbnail,
     this.index
  });
}
