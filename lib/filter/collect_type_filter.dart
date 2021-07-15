import 'package:lottery_app/enums/collect_type.dart';
import 'package:lottery_app/filter/i_transform.dart';
import 'package:lottery_app/models/lottery.dart';

class CollectTypeFilter implements ITransform {
  CollectTypeFilter(this.collectType);
  final CollectType collectType;

  @override
  Iterable<Lottery> transformLotteries(Iterable<Lottery> lotteries) {
    return lotteries.where((lottery) => lottery.collectType == collectType);
  }
}
