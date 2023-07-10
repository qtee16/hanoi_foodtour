import 'dart:io';

import 'package:file_picker/file_picker.dart';

class SelectImage {
  static Future<File?> selectImage() async {
    List<PlatformFile>? _pathsImage = (await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
      onFileLoading: (FilePickerStatus status) => print(status),
    ))?.files;
    if (_pathsImage != null) {
      File imageFile = File(_pathsImage[0].path!);
      return imageFile;
    } else {
      return null;
    }
  }
}