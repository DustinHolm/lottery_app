import 'package:lottery_app/filter/i_transform.dart';
import 'package:lottery_app/models/lottery.dart';

class SellerFilter implements ITransform {
  SellerFilter(this.name);
  final String name;

  @override
  Iterable<Lottery> transformLotteries(Iterable<Lottery> lotteries) {
    return lotteries.where((lottery) => (lottery.seller.name ?? "")
        .toLowerCase()
        .replaceAll(" ", "")
        .contains(name.toLowerCase().replaceAll(" ", "")));
  }
}
