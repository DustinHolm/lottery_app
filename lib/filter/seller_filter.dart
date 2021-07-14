import 'package:lottery_app/enums/filter.dart';
import 'package:lottery_app/filter/transform.dart';
import 'package:lottery_app/models/lottery.dart';

class SellerFilter implements ITransform {
  final String _name;

  SellerFilter(String name) : _name = name;

  @override
  Iterable<Lottery> transformLotteries(Iterable<Lottery> lotteries) {
    return lotteries.where((lottery) => (lottery.seller.name ?? "")
        .toLowerCase()
        .replaceAll(" ", "")
        .contains(_name.toLowerCase().replaceAll(" ", "")));
  }

  @override
  Filter getEnum() {
    return Filter.SELLER_NAME_FILTER;
  }
}
