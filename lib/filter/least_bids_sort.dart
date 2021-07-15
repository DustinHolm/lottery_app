import 'package:lottery_app/filter/i_transform.dart';
import 'package:lottery_app/models/lottery.dart';

class LeastBidsSort implements ITransform {
  final bool asc;

  LeastBidsSort({required this.asc});

  @override
  Iterable<Lottery> transformLotteries(Iterable<Lottery> lotteries) {
    var sortedLotteries = lotteries.toList();
    sortedLotteries.sort((a, b) => asc
        ? a.getTicketsUsed().compareTo(b.getTicketsUsed())
        : b.getTicketsUsed().compareTo(a.getTicketsUsed()));
    return sortedLotteries;
  }
}
