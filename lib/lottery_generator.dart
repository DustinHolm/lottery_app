import 'package:lottery_app/enums/collect_type.dart';
import 'package:lottery_app/enums/condition.dart';
import 'package:lottery_app/enums/payment_type.dart';
import 'package:lottery_app/models/user.dart';

import 'models/address.dart';
import 'models/lottery.dart';
import 'models/product.dart';

class LotteryGenerator {
  static generateLotteries(int n, int? oldIndex) {
    int index = (oldIndex == null) ? 0 : oldIndex;

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
            endingDate: DateTime.now(),
            ticketsMap: defaultUserMap(i + index),
            seller: new User(name: "TestUser_${i + index}", address: new Address()),
            winner: null,
            collectType: CollectType.PACKET,
            paymentType: PaymentType.CREDIT_CARD));
  }
}

Map<User, int> defaultUserMap(int i) => {
      User(name: "Sandra_$i", address: Address()): i,
      User(name: "Peter_$i", address: Address()): i * 2,
      User(name: "Heinz_$i", address: Address()): i * 3,
    };
