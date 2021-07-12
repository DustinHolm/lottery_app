import 'package:lottery_app/filter/transform.dart';
import 'package:lottery_app/models/lottery.dart';

class BidOnFilter implements ITransform {
  BidOnFilter({required this.userId});

  final String userId;

  @override
  Iterable<Lottery> transformLotteries(Iterable<Lottery> lotteries) {
    return lotteries.where((lottery) => lottery.ticketMap.keys.contains(userId));
  }
}
