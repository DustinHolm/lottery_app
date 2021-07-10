import 'package:flutter_test/flutter_test.dart';
import 'package:lottery_app/enums/category.dart';
import 'package:lottery_app/enums/collect_type.dart';
import 'package:lottery_app/enums/condition.dart';
import 'package:lottery_app/models/app_user.dart';
import 'package:lottery_app/models/bid_tickets.dart';
import 'package:lottery_app/models/lottery.dart';

void main() {
  group("JSON serialization and deserialization tests", () {
    AppUser getSeller() => AppUser(id: "SellerId", name: "SellerName",);
    AppUser getWinner() => AppUser(id: "WinnerId", name: "WinnerName",);
    BidTickets getBidTickets() => BidTickets(ticketMap: {});
    Lottery getBaseLottery() => Lottery.withRandomId(
      name: "Name",
      description: "Description",
      image: null,
      condition: Condition.GOOD,
      category: Category.BOOKS,
      shippingCost: 21,
      endingDate: DateTime.now(),
      bidTickets: getBidTickets(),
      seller: getSeller(),
      winner: null,
      collectType: CollectType.PACKET_INLAND,
    );

    test("AppUser is same", () {
        AppUser original = getSeller();
        AppUser copy = AppUser.fromJson(original.toJson());
        expect(copy, original);
    });

    test("BidTickets is same if empty", () {
        BidTickets original = getBidTickets();
        BidTickets copy = BidTickets.fromJson(original.toJson());
        expect(copy, original);
    });

    test("BidTickets is same if not empty", () {
        BidTickets original = getBidTickets();
        original.ticketMap["user1"] = 10;
        original.ticketMap["user2"] = 20;
        original.ticketMap["user3"] = 30;
        original.ticketMap["user4"] = 40;
        original.nextWinner = "user3";
        BidTickets copy = BidTickets.fromJson(original.toJson());
        expect(copy, original);
    });

    test("BidTickets is same if end result is same", () {
        BidTickets original = getBidTickets();
        original.ticketMap["user1"] = 10;
        original.ticketMap["user2"] = 20;
        original.ticketMap["user3"] = 30;
        original.ticketMap["user4"] = 40;
        BidTickets copy = BidTickets.fromJson(original.toJson());
        copy.ticketMap.remove("user1");
        copy.ticketMap["user1"] = 1;
        copy.ticketMap["user1"] = 10;
        expect(copy, original);
    });

    test("BidTickets is different if different ticketMap", () {
        BidTickets original = getBidTickets();
        original.ticketMap["user1"] = 10;
        original.ticketMap["user2"] = 20;
        original.ticketMap["user3"] = 30;
        original.ticketMap["user4"] = 40;
        BidTickets copy = BidTickets.fromJson(original.toJson());
        copy.ticketMap["user1"] = 1;
        expect(copy, isNot(original));
    });

    test("BidTickets is different if different winner", () {
        BidTickets original = getBidTickets();
        original.ticketMap["user1"] = 10;
        original.ticketMap["user2"] = 20;
        original.ticketMap["user3"] = 30;
        original.ticketMap["user4"] = 40;
        original.nextWinner = "user3";
        BidTickets copy = BidTickets.fromJson(original.toJson());
        copy.nextWinner = "user4";
        expect(copy, isNot(original));
    });

    test("Lottery is same", () {
      Lottery original = getBaseLottery();
      Lottery copy = Lottery.fromJson(original.toJson());
      expect(copy, original);
    });

    test("Lottery is same with all attributes set", () {
      Lottery original = getBaseLottery();
      original.winner = getWinner();
      original.image = null; //TODO: Images need to be implemented
      Lottery copy = Lottery.fromJson(original.toJson());
      expect(copy, original);
    });

    test("Lottery is different with different endingDate", () {
      Lottery original = getBaseLottery();
      Lottery copy = Lottery.fromJson(original.toJson());
      copy.endingDate = copy.endingDate.add(const Duration(seconds: 5));
      expect(copy, isNot(original));
    });

    // No other tests for differences, because the rest are simple types.
  });
}
