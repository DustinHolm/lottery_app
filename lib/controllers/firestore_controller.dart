import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottery_app/models/lottery.dart';

class FirestoreController {
  static final firestore = FirebaseFirestore.instance;

  static Future getLotteries() {
    return firestore.collection("lotteries").get();
  }

  static Future addLottery(Lottery lottery) {
    return firestore.collection("lotteries").doc(lottery.id).set({"name": lottery.name});
  }
}