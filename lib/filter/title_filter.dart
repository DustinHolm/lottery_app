import 'package:lottery_app/filter/i_transform.dart';
import 'package:lottery_app/models/lottery.dart';

class TitleFilter implements ITransform {
  TitleFilter(this.title);
  final String title;

  @override
  Iterable<Lottery> transformLotteries(Iterable<Lottery> lotteries) {
    return lotteries.where(
        (lottery) => lottery.name.toLowerCase().contains(title.toLowerCase()));
  }
}
