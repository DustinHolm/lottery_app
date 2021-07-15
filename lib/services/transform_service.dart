import 'dart:collection';

import 'package:lottery_app/filter/i_transform.dart';
import 'package:lottery_app/models/lottery.dart';

class TransformService {
  static UnmodifiableListView<Lottery> withAll(List<Lottery> lotteries, List<ITransform> transformations) {
    return UnmodifiableListView(transformations
        .fold(
        lotteries,
            (Iterable<Lottery> previousValue, transform) =>
            transform.transformLotteries(previousValue))
        .toList());
  }

  static UnmodifiableListView<Lottery> withAny(List<Lottery> lotteries, List<ITransform> transformations) {
    Set<Lottery> lotterySet = {};

    for (ITransform transform in transformations) {
      lotterySet.addAll(transform.transformLotteries(lotteries));
    }

    return UnmodifiableListView(lotterySet.toList());
  }
}