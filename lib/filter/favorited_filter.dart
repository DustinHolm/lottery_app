import 'package:lottery_app/filter/i_transform.dart';
import 'package:lottery_app/models/lottery.dart';

class IdFilter implements ITransform {
  IdFilter({required this.ids});

  final List<String> ids;

  @override
  Iterable<Lottery> transformLotteries(Iterable<Lottery> lotteries) {
    return lotteries.where((lottery) => ids.contains(lottery.id));
  }
}