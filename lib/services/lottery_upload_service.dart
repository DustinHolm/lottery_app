import 'package:lottery_app/controllers/firestore_controller.dart';
import 'package:lottery_app/controllers/storage_controller.dart';
import 'package:lottery_app/models/lottery.dart';
import 'package:image_picker/image_picker.dart';


class LotteryUploadService {
  static Future<void> upload(Lottery lottery, PickedFile? image) async {
    String? link;
    if (image != null) {
      link = await StorageController.uploadImage(image, lottery.id);
    }
    lottery.image = link;
    await FirestoreController.addLottery(lottery);
  }
}