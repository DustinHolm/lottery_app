import 'package:lottery_app/filter/transform.dart';
import 'package:lottery_app/models/lottery.dart';

class TitleFilter implements ITransform {
  String _title;

  TitleFilter(String title) : _title = title;

  @override
  Iterable<Lottery> transformLotteries(Iterable<Lottery> lotteries) {
    return lotteries.where((lottery) => lottery.name.contains(_title));
  }
}
