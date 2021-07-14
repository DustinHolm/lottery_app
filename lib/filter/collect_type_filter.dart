import 'package:lottery_app/enums/collect_type.dart';
import 'package:lottery_app/enums/filter.dart';
import 'package:lottery_app/filter/transform.dart';
import 'package:lottery_app/models/lottery.dart';

class CollectTypeFilter implements ITransform {
  final CollectType _collectType;

  CollectTypeFilter(CollectType collectType) : _collectType = collectType;

  @override
  Iterable<Lottery> transformLotteries(Iterable<Lottery> lotteries) {
    return lotteries.where((lottery) => lottery.collectType == _collectType);
  }

  @override
  Filter getEnum() {
    return Filter.COLLECT_TYPE_FILTER;
  }
}
