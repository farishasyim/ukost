import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class FilePickerHelper {
  static Future<List<File>> pickFile(
      {FileType fileType = FileType.any, bool allowMultiple = false}) async {
    var file = await FilePicker.platform.pickFiles(
      type: fileType,
      allowMultiple: allowMultiple,
    );
    if (file != null && file.files.isNotEmpty) {
      return file.files.map((a) => File(a.path!)).toList();
    }
    return [];
  }

  static Future<File?> takePicture() async {
    var file = await ImagePicker().pickImage(source: ImageSource.camera);

    if (file != null) {
      return File(file.path);
    }
    return null;
  }
}
