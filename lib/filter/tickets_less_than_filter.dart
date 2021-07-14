import 'package:lottery_app/filter/i_transform.dart';
import 'package:lottery_app/models/lottery.dart';

class TicketsLessThanFilter implements ITransform {
  TicketsLessThanFilter(this.n);
  final int n;

  @override
  Iterable<Lottery> transformLotteries(Iterable<Lottery> lotteries) {
    return lotteries.where((lottery) => lottery.getTicketsUsed() < n);
  }
}
