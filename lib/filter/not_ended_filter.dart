import 'package:lottery_app/filter/i_transform.dart';
import 'package:lottery_app/models/lottery.dart';

class NotEndedFilter implements ITransform {
  @override
  Iterable<Lottery> transformLotteries(Iterable<Lottery> lotteries) {
    return lotteries.where((lottery) => lottery.endingDate.isAfter(DateTime.now()));
  }
}
