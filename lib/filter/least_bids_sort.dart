import 'package:lottery_app/filter/transform.dart';
import 'package:lottery_app/models/lottery.dart';

class LeastBidsSort implements ITransform {
  @override
  Iterable<Lottery> transformLotteries(Iterable<Lottery> lotteries) {
    var sortedLotteries = lotteries.toList();
    sortedLotteries
        .sort((a, b) => a.getTicketsUsed().compareTo(b.getTicketsUsed()));
    return sortedLotteries;
  }
}
