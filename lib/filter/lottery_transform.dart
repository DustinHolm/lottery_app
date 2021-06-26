import 'dart:collection';

import 'package:lottery_app/models/lottery.dart';

import 'transform.dart';

class LotteryTransform {
  List<ITransform> _transforms = List.empty(growable: true);

  void add(ITransform transform) {
    _transforms.add(transform);
  }

  void remove(ITransform transform) {
    _transforms.remove(transform);
  }

  UnmodifiableListView<Lottery> getTransformed(List<Lottery> lotteries) {
    return UnmodifiableListView(_transforms
        .fold(
            lotteries,
            (Iterable<Lottery> previousValue, transform) =>
                transform.transformLotteries(previousValue))
        .toList());
  }
}
