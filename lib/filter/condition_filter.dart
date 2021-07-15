import 'package:lottery_app/enums/condition.dart';
import 'package:lottery_app/filter/i_transform.dart';
import 'package:lottery_app/models/lottery.dart';

class ConditionFilter implements ITransform {
  ConditionFilter(this.condition);
  final Condition condition;

  @override
  Iterable<Lottery> transformLotteries(Iterable<Lottery> lotteries) {
    return lotteries
        .where((lottery) => lottery.condition == condition);
  }
}
