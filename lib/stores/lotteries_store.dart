import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:lottery_app/models/lottery.dart';

class LotteriesStore extends ChangeNotifier {
  List<Lottery> _lotteries = List.empty();

  UnmodifiableListView<Lottery> get lotteries => UnmodifiableListView(_lotteries);

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
}