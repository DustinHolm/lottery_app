import 'package:flutter_test/flutter_test.dart';
import 'package:lottery_app/models/app_user.dart';
import 'package:lottery_app/models/lottery.dart';

import 'defaults.dart';

void main() {
  group("JSON serialization and deserialization tests", () {

    test("AppUser is same", () {
        AppUser original = Defaults.getSeller();
        AppUser copy = AppUser.fromJson(original.toJson());
        expect(copy, original);
    });

    test("Lottery is same", () {
      Lottery original = Defaults.getBaseLottery();
      Lottery copy = Lottery.fromJson(original.toJson());
      expect(copy, original);
    });

    test("Lottery is same with all attributes set", () {
      Lottery original = Defaults.getBaseLottery();
      original.winner = Defaults.getWinner();
      original.image = "This is not an URL";
      Lottery copy = Lottery.fromJson(original.toJson());
      expect(copy, original);
    });

    test("Lottery is same with same ticketsMap result", () {
      Lottery original = Defaults.getBaseLottery();
      original.winner = Defaults.getWinner();
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
      Lottery original = Defaults.getBaseLottery();
      Lottery copy = Lottery.fromJson(original.toJson());
      copy.endingDate = copy.endingDate.add(const Duration(seconds: 5));
      expect(copy, isNot(original));
    });

    test("Lottery is different with different ticketMap", () {
      Lottery original = Defaults.getBaseLottery();
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
