import 'package:lottery_app/filter/transform.dart';
import 'package:lottery_app/models/lottery.dart';

class EndingDateFilter implements ITransform {
  DateTime _date;

  EndingDateFilter(DateTime date) : _date = date;

  @override
  Iterable<Lottery> transformLotteries(Iterable<Lottery> lotteries) {
    return lotteries.where((lottery) => lottery.endingDate.isBefore(_date));
  }
}
