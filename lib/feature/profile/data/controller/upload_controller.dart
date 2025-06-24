import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';

class UploadController extends GetxController {
  var isUploading = false.obs;
  var selectedFile = Rxn<PlatformFile>();
  late DropzoneViewController dropzoneController;

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      selectedFile.value = result.files.first;
      Get.snackbar("File Selected", "${selectedFile.value?.name}");
    }
  }

  void uploadFile() {
    if (selectedFile.value == null) {
      Get.snackbar("Error", "No file selected");
      return;
    }
    isUploading.value = true;
    Future.delayed(Duration(seconds: 2), () {
      isUploading.value = false;
      Get.snackbar("Success", "File uploaded successfully");
    });
  }

  void handleDrop(dynamic file) async {
    String fileName = await dropzoneController.getFilename(file);
    int fileSize = await dropzoneController.getFileSize(file);
    Uint8List fileData = await dropzoneController.getFileData(file);

    selectedFile.value = PlatformFile(name: fileName, size: fileSize, bytes: fileData);
    Get.snackbar("File Dropped", "$fileName selected");
  }
}