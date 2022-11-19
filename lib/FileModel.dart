class FileModel {
  List<String> files;
  String folder;

  FileModel({required this.files, required this.folder});

  factory FileModel.fromJson(Map<String, dynamic> json) {
    return FileModel(
        files: json['files'].cast<String>(), folder: json['folderName']);
  }
}
