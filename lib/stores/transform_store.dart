import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:lottery_app/filter/transform.dart';
import 'package:lottery_app/models/lottery.dart';

class TransformStore extends ChangeNotifier {
  List<ITransform> _transforms = List.empty(growable: true);

  List<ITransform> get transforms => _transforms;

  void add(ITransform transform) {
    _transforms.add(transform);
    notifyListeners();
  }

  void remove(ITransform transform) {
    _transforms.remove(transform);
    notifyListeners();
  }

  void clear() {
    _transforms.clear();
    notifyListeners();
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
