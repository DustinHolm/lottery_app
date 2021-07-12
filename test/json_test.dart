import 'package:flutter_test/flutter_test.dart';
import 'package:lottery_app/enums/category.dart';
import 'package:lottery_app/enums/collect_type.dart';
import 'package:lottery_app/enums/condition.dart';
import 'package:lottery_app/models/app_user.dart';
import 'package:lottery_app/models/lottery.dart';

void main() {
  group("JSON serialization and deserialization tests", () {
    AppUser getSeller() => AppUser(id: "SellerId", name: "SellerName",);
    AppUser getWinner() => AppUser(id: "WinnerId", name: "WinnerName",);
    Lottery getBaseLottery() => Lottery.withRandomId(
      name: "Name",
      description: "Description",
      image: null,
      condition: Condition.GOOD,
      category: Category.BOOKS,
      shippingCost: 21,
      endingDate: DateTime.now(),
      ticketMap: {},
      seller: getSeller(),
      winner: null,
      collectType: CollectType.PACKET_INLAND,
    );

    test("AppUser is same", () {
        AppUser original = getSeller();
        AppUser copy = AppUser.fromJson(original.toJson());
        expect(copy, original);
    });

    test("Lottery is same", () {
      Lottery original = getBaseLottery();
      Lottery copy = Lottery.fromJson(original.toJson());
      expect(copy, original);
    });

    test("Lottery is same with all attributes set", () {
      Lottery original = getBaseLottery();
      original.winner = getWinner();
      original.image = "This is not an URL";
      Lottery copy = Lottery.fromJson(original.toJson());
      expect(copy, original);
    });

    test("Lottery is same with same ticketsMap result", () {
      Lottery original = getBaseLottery();
      original.winner = getWinner();
      original.image = "This is not an URL";
      original.ticketMap["user1"] = 10;
      original.ticketMap["user2"] = 20;
      original.ticketMap["user3"] = 30;
      original.ticketMap["user4"] = 40;
      Lottery copy = Lottery.fromJson(original.toJson());
      copy.ticketMap.remove("user1");
      copy.ticketMap["user1"] = 1;
      copy.ticketMap["user1"] = 10;
      expect(copy, original);
    });

    test("Lottery is different with different endingDate", () {
      Lottery original = getBaseLottery();
      Lottery copy = Lottery.fromJson(original.toJson());
      copy.endingDate = copy.endingDate.add(const Duration(seconds: 5));
      expect(copy, isNot(original));
    });

    test("Lottery is different with different ticketMap", () {
      Lottery original = getBaseLottery();
      original.ticketMap["user1"] = 10;
      original.ticketMap["user2"] = 20;
      original.ticketMap["user3"] = 30;
      original.ticketMap["user4"] = 40;
      Lottery copy = Lottery.fromJson(original.toJson());
      copy.ticketMap["user1"] = 1;
      expect(copy, isNot(original));
    });

    // No other tests for differences, because the rest are simple types.
  });
}
