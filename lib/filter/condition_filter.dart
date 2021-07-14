import 'package:lottery_app/enums/condition.dart';
import 'package:lottery_app/enums/filter.dart';
import 'package:lottery_app/filter/transform.dart';
import 'package:lottery_app/models/lottery.dart';

class ConditionFilter implements ITransform {
  final Condition _condition;

  ConditionFilter(Condition condition) : _condition = condition;

  @override
  Iterable<Lottery> transformLotteries(Iterable<Lottery> lotteries) {
    return lotteries.where((lottery) => lottery.condition == _condition);
  }

  @override
  Filter getEnum() {
    return Filter.CONDITION_FILTER;
  }
}
