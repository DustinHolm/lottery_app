import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class StorageController {
  static final FirebaseStorage _storage = FirebaseStorage.instance;

  static Future<String?> uploadImage(PickedFile image, String lotteryId) async {
    Reference fileRef = _storage.ref("lotteryImages/$lotteryId");
    UploadTask task = fileRef.putFile(File(image.path));
    TaskSnapshot snapshot = await task;
    if (snapshot.state == TaskState.success) {
      return fileRef.getDownloadURL();
    } else {
      return null;
    }
  }
}
