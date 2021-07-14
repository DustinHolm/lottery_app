import 'package:lottery_app/enums/filter.dart';
import 'package:lottery_app/models/lottery.dart';

abstract class ITransform {
  Iterable<Lottery> transformLotteries(Iterable<Lottery> lotteries);
  Filter? getEnum();
}
