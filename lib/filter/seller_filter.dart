import 'package:lottery_app/filter/transform.dart';
import 'package:lottery_app/models/lottery.dart';

class SellerFilter implements ITransform {
  String _name;

  SellerFilter(String name) : _name = name;

  @override
  Iterable<Lottery> transformLotteries(Iterable<Lottery> lotteries) {
    return lotteries.where((lottery) => lottery.seller.name == _name);
  }
}
