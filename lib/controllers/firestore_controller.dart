  import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottery_app/models/lottery.dart';

class FirestoreController {
  static final firestore = FirebaseFirestore.instance;

  static Stream<List<Lottery>> getLotteries() {
    return firestore.collection("lotteries").snapshots().map((snap) =>
        snap.docs.map((doc) => Lottery.fromJson(doc.data())).toList());
  }

  static Future addLottery(Lottery lottery) {
    return firestore
        .collection("lotteries")
        .doc(lottery.id)
        .set(lottery.toJson());
  }

  static Future updateLottery(Lottery lottery) {
    return firestore
        .collection("lotteries")
        .doc(lottery.id)
        .update(lottery.toJson());
  }
}
