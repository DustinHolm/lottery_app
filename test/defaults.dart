import 'package:lottery_app/enums/category.dart';
import 'package:lottery_app/enums/collect_type.dart';
import 'package:lottery_app/enums/condition.dart';
import 'package:lottery_app/models/app_user.dart';
import 'package:lottery_app/models/lottery.dart';

class Defaults {
  static AppUser getSeller() => AppUser(id: "SellerId", name: "SellerName",);
  static AppUser getWinner() => AppUser(id: "WinnerId", name: "WinnerName",);

  static Lottery getBaseLottery([String name = "Test", int condition = 0, int category = 0, int collectType = 0]) =>
      Lottery.withRandomId(
        name: name,
        description: "Description",
        image: null,
        condition: Condition.values[condition],
        category: Category.values[category],
        shippingCost: 21,
        endingDate: DateTime.parse("2012-02-27 13:27:00"),
        ticketMap: {},
        seller: getSeller(),
        winner: null,
        collectType: CollectType.values[collectType],
      );

  static List<Lottery> getLotteries() {
    List<Lottery> lotteries = [];

    for (var i = 0; i <= 8; i++) {
      lotteries.add(getBaseLottery("Test" + i.toString(), i % 5, i, i % 3));
      lotteries.add(getBaseLottery("2Test" + i.toString(), i % 5, i, i % 3));
    }

    return lotteries;
  }
}