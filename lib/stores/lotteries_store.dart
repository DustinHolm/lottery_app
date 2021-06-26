import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:lottery_app/models/lottery.dart';
import 'package:lottery_app/models/user.dart';

class LotteriesStore extends ChangeNotifier {
  List<Lottery> _lotteries = List.empty();

  UnmodifiableListView<Lottery> get lotteries =>
      UnmodifiableListView(_lotteries);

  set lotteries(List<Lottery> lotteries) {
    _lotteries = lotteries;
    notifyListeners();
  }

  void addLottery(Lottery lottery) {
    _lotteries.add(lottery);
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

  void bidOnLottery(Lottery lottery, User user) {
    lottery.ticketsMap.update(
        user, (val) => val += 1, ifAbsent: () => 1);
    _lotteries[_lotteries.indexOf(lottery)] = lottery;
    notifyListeners();
  }

  UnmodifiableListView<Lottery> getBidOnLotteries(User? user) {
    if (user != null) {
      return UnmodifiableListView(_lotteries
          .where((lottery) => lottery.ticketsMap.keys.contains(user)));
    } else {
      return UnmodifiableListView(List.empty());
    }
  }

  UnmodifiableListView<Lottery> getOwnedLotteries(User? user) {
    if (user != null) {
      return UnmodifiableListView(_lotteries
          .where((lottery) => lottery.seller == user));
    } else {
      return UnmodifiableListView(List.empty());
    }
  }
}
