import 'package:flutter_test/flutter_test.dart';

import 'package:lottery_app/models/lottery.dart';
import 'package:lottery_app/enums/category.dart';
import 'package:lottery_app/enums/collect_type.dart';
import 'package:lottery_app/enums/condition.dart';
import 'package:lottery_app/filter/category_filter.dart';
import 'package:lottery_app/filter/collect_type_filter.dart';
import 'package:lottery_app/filter/condition_filter.dart';
import 'package:lottery_app/filter/ending_soonest_sort.dart';
import 'package:lottery_app/filter/least_bids_sort.dart';
import 'package:lottery_app/filter/seller_filter.dart';
import 'package:lottery_app/filter/tickets_less_than_filter.dart';
import 'package:lottery_app/filter/title_filter.dart';

import 'defaults.dart';

void main(){

  List<Lottery> lotteries = Defaults.getLotteries();
  List<Lottery> lotteries2 = lotteries;

  group('Category', (){

    test('Lotteries should be filtered by category OTHER',(){

      Iterable<Lottery> filteredLotteries = CategoryFilter(Category.OTHER).transformLotteries(lotteries);
      expect(filteredLotteries,lotteries2.where((lottery) => lottery.category == Category.OTHER));
      expect(filteredLotteries.toList().length, 2);
    });

    test('Lotteries should be filtered by category ELECTRONICS',(){

      Iterable<Lottery> filteredLotteries = CategoryFilter(Category.ELECTRONICS).transformLotteries(lotteries);
      expect(filteredLotteries,lotteries2.where((lottery) => lottery.category == Category.ELECTRONICS));
      expect(filteredLotteries.toList().length, 2);
    });

    test('Lotteries should be filtered by category KITCHEN',(){

      Iterable<Lottery> filteredLotteries = CategoryFilter(Category.KITCHEN).transformLotteries(lotteries);
      expect(filteredLotteries,lotteries2.where((lottery) => lottery.category == Category.KITCHEN));
      expect(filteredLotteries.toList().length, 2);
    });

    test('Lotteries should be filtered by category APPLIANCES',(){

      Iterable<Lottery> filteredLotteries = CategoryFilter(Category.APPLIANCES).transformLotteries(lotteries);
      expect(filteredLotteries,lotteries2.where((lottery) => lottery.category == Category.APPLIANCES));
      expect(filteredLotteries.toList().length, 2);
    });

    test('Lotteries should be filtered by category FURNITURE',(){

      Iterable<Lottery> filteredLotteries = CategoryFilter(Category.FURNITURE).transformLotteries(lotteries);
      expect(filteredLotteries,lotteries2.where((lottery) => lottery.category == Category.FURNITURE));
      expect(filteredLotteries.toList().length, 2);
    });

    test('Lotteries should be filtered by category DECORATION',(){

      Iterable<Lottery> filteredLotteries = CategoryFilter(Category.DECORATION).transformLotteries(lotteries);
      expect(filteredLotteries,lotteries2.where((lottery) => lottery.category == Category.DECORATION));
      expect(filteredLotteries.toList().length, 2);
    });

    test('Lotteries should be filtered by category GARDEN',(){

      Iterable<Lottery> filteredLotteries = CategoryFilter(Category.GARDEN).transformLotteries(lotteries);
      expect(filteredLotteries,lotteries2.where((lottery) => lottery.category == Category.GARDEN));
      expect(filteredLotteries.toList().length, 2);
    });

    test('Lotteries should be filtered by category BOOKS',(){

      Iterable<Lottery> filteredLotteries = CategoryFilter(Category.BOOKS).transformLotteries(lotteries);
      expect(filteredLotteries,lotteries2.where((lottery) => lottery.category == Category.BOOKS));
      expect(filteredLotteries.toList().length, 2);
    });

    test('Lotteries should be filtered by category CLOTHES',(){

      Iterable<Lottery> filteredLotteries = CategoryFilter(Category.CLOTHES).transformLotteries(lotteries);
      expect(filteredLotteries,lotteries2.where((lottery) => lottery.category == Category.CLOTHES));
      expect(filteredLotteries.toList().length, 2);
    });

  });

  test('Lotteries should be filtered by seller', (){
    Iterable<Lottery> filteredLotteries = SellerFilter(Defaults.getSeller().name.toString()).transformLotteries(lotteries);
    expect(filteredLotteries,lotteries2.where((lottery) => (lottery.seller.name ?? "")
        .toLowerCase()
        .replaceAll(" ", "")
        .contains(Defaults.getSeller().name.toString().toLowerCase().replaceAll(" ", ""))));
    expect(filteredLotteries.toList().length, 18);
  });

  test('Lotteries should be filtered by title',(){
    Iterable<Lottery> filteredLotteries = TitleFilter("2Test5").transformLotteries(lotteries);
    expect(filteredLotteries.toList().length,1);

  });

  test('Lotteries should be filtered by less Tickets than Filter' ,(){
    Iterable<Lottery> filteredLotteries = TicketsLessThanFilter(5).transformLotteries(lotteries);
    expect(filteredLotteries.toList().length,18);
  });

  group('CollectType',(){

    test('Lotteries should be filtered by SELF_COLLECT' ,(){
      Iterable<Lottery> filteredLotteries = CollectTypeFilter(CollectType.SELF_COLLECT).transformLotteries(lotteries);
      expect(filteredLotteries.toList().length,6);
    });

    test('Lotteries should be filtered by PACKET' ,(){
      Iterable<Lottery> filteredLotteries = CollectTypeFilter(CollectType.PACKET).transformLotteries(lotteries);
      expect(filteredLotteries.toList().length,6);
    });

    test('Lotteries should be filtered by PACKET_INLAND' ,(){
      Iterable<Lottery> filteredLotteries = CollectTypeFilter(CollectType.PACKET_INLAND).transformLotteries(lotteries);
      expect(filteredLotteries.toList().length,6);
    });
  });

    group('Condition',(){

      test('Lotteries should be filtered by Condition NEW' ,(){
        Iterable<Lottery> filteredLotteries = ConditionFilter(Condition.NEW).transformLotteries(lotteries);
        expect(filteredLotteries.toList().length,4);
      });

      test('Lotteries should be filtered by Condition LIKE_NEW' ,(){
        Iterable<Lottery> filteredLotteries = ConditionFilter(Condition.LIKE_NEW).transformLotteries(lotteries);
        expect(filteredLotteries.toList().length,4);
      });

      test('Lotteries should be filtered by Condition GOOD' ,(){
        Iterable<Lottery> filteredLotteries = ConditionFilter(Condition.GOOD).transformLotteries(lotteries);
        expect(filteredLotteries.toList().length,4);
      });

      test('Lotteries should be filtered by Condition OK' ,(){
        Iterable<Lottery> filteredLotteries = ConditionFilter(Condition.OK).transformLotteries(lotteries);
        expect(filteredLotteries.toList().length,4);
      });

      test('Lotteries should be filtered by Condition BAD' ,(){
        Iterable<Lottery> filteredLotteries = ConditionFilter(Condition.BAD).transformLotteries(lotteries);
        expect(filteredLotteries.toList().length,2);
      });
    });

  test('Lotteries should be sorted by ending soonest' ,(){
    Iterable<Lottery> filteredLotteries = EndingSoonestSort().transformLotteries(lotteries);
    expect(filteredLotteries.toList(),lotteries);
  }); //since they are build in a loop with DateTime.now() they are in the right order

  test('Lotteries should be sorted by least bids' ,(){
    Iterable<Lottery> filteredLotteries = LeastBidsSort(asc: true).transformLotteries(lotteries);
    expect(filteredLotteries.toList(),lotteries);
    //since they are build in a loop with the same amount of tickets they are in the right order
  });

  //least bids is only tested in one direction as both will work if one works as intended


}