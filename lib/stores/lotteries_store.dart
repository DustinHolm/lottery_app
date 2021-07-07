import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:lottery_app/models/lottery.dart';
import 'package:lottery_app/models/app_user.dart';
import 'package:lottery_app/services/local_storage_service.dart';

class LotteriesStore extends ChangeNotifier {
  List<Lottery> _lotteries = List.empty();

  UnmodifiableListView<Lottery> get lotteries =>
      UnmodifiableListView(_lotteries);

  set lotteries(List<Lottery> lotteries) {
    _lotteries = lotteries;
    notifyListeners();
  }

  void addLottery(Lottery lottery) {
    _lotteries = [..._lotteries, lottery];
    notifyListeners();
  }

  void addLotteries(List<Lottery> lotteries) {
    _lotteries = [..._lotteries, ...lotteries];
    notifyListeners();
  }

  void removeLottery(Lottery lottery) {
    _lotteries.remove(lottery);
    notifyListeners();
  }

  void bidOnLottery(Lottery lottery, AppUser user) {
    lottery.ticketsMap.update(user, (val) => val += 1, ifAbsent: () => 1);
    _lotteries[_lotteries.indexOf(lottery)] = lottery;
    notifyListeners();
  }

  UnmodifiableListView<Lottery> getBidOnLotteries(AppUser? user) {
    if (user != null) {
      return UnmodifiableListView(_lotteries
          .where((lottery) => lottery.ticketsMap.keys.contains(user)));
    } else {
      return UnmodifiableListView(List.empty());
    }
  }

  Future<UnmodifiableListView<Lottery>> getBidOnAndFavoritedLotteries(
      AppUser? user) async {
    if (user != null) {
      List<String> favorites = await LocalStorageService.getFavoriteIds();
      return UnmodifiableListView(_lotteries.where((lottery) =>
          lottery.ticketsMap.keys.contains(user) ||
          favorites.contains(lottery.id)));
    } else {
      return UnmodifiableListView(List.empty());
    }
  }

  UnmodifiableListView<Lottery> getOwnedLotteries(AppUser? user) {
    if (user != null) {
      return UnmodifiableListView(
          _lotteries.where((lottery) => lottery.seller == user));
    } else {
      return UnmodifiableListView(List.empty());
    }
  }

  UnmodifiableListView<Lottery> getAvailableLotteries(AppUser? user) {
    if (user != null) {
      return UnmodifiableListView(_lotteries.where((lottery) =>
          lottery.seller != user &&
          lottery.endingDate.isAfter(DateTime.now())));
    } else {
      return UnmodifiableListView(_lotteries);
    }
  }
}
