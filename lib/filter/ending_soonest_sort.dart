import 'package:lottery_app/filter/transform.dart';
import 'package:lottery_app/models/lottery.dart';

class EndingSoonestSort implements ITransform {
  @override
  Iterable<Lottery> transformLotteries(Iterable<Lottery> lotteries) {
    lotteries.toList().sort((a, b) => a.endingDate.compareTo(b.endingDate));
    return lotteries;
  }
}
