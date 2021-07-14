import 'package:lottery_app/enums/filter.dart';
import 'package:lottery_app/filter/transform.dart';
import 'package:lottery_app/models/lottery.dart';

class TicketsLessThanFilter implements ITransform {
  final int _n;

  TicketsLessThanFilter(int n) : _n = n;

  @override
  Iterable<Lottery> transformLotteries(Iterable<Lottery> lotteries) {
    return lotteries.where((lottery) => lottery.getTicketsUsed() < _n);
  }

  @override
  Filter getEnum() {
    return Filter.TICKETS_LESS_THAN_FILTER;
  }
}
