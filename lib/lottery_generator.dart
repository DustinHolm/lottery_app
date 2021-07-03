import 'dart:math';

import 'package:lottery_app/enums/collect_type.dart';
import 'package:lottery_app/enums/condition.dart';
import 'package:lottery_app/enums/payment_type.dart';
import 'package:lottery_app/models/app_user.dart';

import 'models/address.dart';
import 'models/lottery.dart';
import 'models/product.dart';

class LotteryGenerator {
  static generateLotteries(int n, int? oldIndex) {
    int index = (oldIndex == null) ? 0 : oldIndex;
    DateTime getRandomEndingDate() {
      int seconds = Random().nextInt(Duration.secondsPerHour * 2);
      return DateTime.now().add(Duration(seconds: seconds));
    }

    return new List.generate(
        n,
        (int i) => new Lottery(
            product: new Product(
                name: "Product_${i + index}",
                description: "Description_${i + index}",
                images: new List.empty(),
                condition: Condition.GOOD,
                shippingCost: 0),
            startingDate: DateTime.now(),
            endingDate: getRandomEndingDate(),
            ticketsMap: defaultUserMap(i + index),
            seller: new AppUser(name: "TestUser_${i + index}", address: new Address()),
            winner: null,
            collectType: CollectType.PACKET,
            paymentType: PaymentType.CREDIT_CARD));
  }
}

Map<AppUser, int> defaultUserMap(int i) => {
      AppUser(name: "Sandra_$i", address: Address()): i,
      AppUser(name: "Peter_$i", address: Address()): i * 2,
      AppUser(name: "Heinz_$i", address: Address()): i * 3,
    };
