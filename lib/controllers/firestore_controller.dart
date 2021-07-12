  import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottery_app/models/app_user.dart';
import 'package:lottery_app/models/lottery.dart';

class FirestoreController {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Stream<List<Lottery>> getLotteries() {
    return _firestore.collection("lotteries").snapshots().map((snap) =>
        snap.docs.map((doc) => Lottery.fromJson(doc.data())).toList());
  }

  static Future addLottery(Lottery lottery) {
    return _firestore
        .collection("lotteries")
        .doc(lottery.id)
        .set(lottery.toJson());
  }

  static Future updateLottery(Lottery lottery) {
    print(lottery.toJson());
    return _firestore
        .collection("lotteries")
        .doc(lottery.id)
        .update(lottery.toJson());
  }

  static Future setUser(AppUser user) {
    return _firestore
        .collection("users")
        .doc(user.id)
        .set(user.toJson());
  }

  static Future<AppUser?> getUser(String userId) async {
    var snapshot = await _firestore
        .collection("users")
        .doc(userId)
        .get();
    if (snapshot.exists) {
      return AppUser.fromJson(snapshot.data()!);
    } else {
      return null;
    }
  }

  static Future updateUser(AppUser user) {
    return _firestore
        .collection("users")
        .doc(user.id)
        .update(user.toJson());
  }
}
