import 'package:lottery_app/filter/transform.dart';
import 'package:lottery_app/models/lottery.dart';

class TicketsLessThanFilter implements ITransform {
  var n;

  TicketsLessThanFilter(int n) : n = n;

  @override
  Iterable<Lottery> transformLotteries(Iterable<Lottery> lotteries) {
    return lotteries.where((lottery) => lottery.getTicketsUsed() < this.n);
  }
}