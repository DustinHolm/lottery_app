import 'package:lottery_app/enums/category.dart';
import 'package:lottery_app/filter/i_transform.dart';
import 'package:lottery_app/models/lottery.dart';

class CategoryFilter implements ITransform {
  CategoryFilter(this.category);
  final Category category;

  @override
  Iterable<Lottery> transformLotteries(Iterable<Lottery> lotteries) {
    return lotteries.where((lottery) => lottery.category == category);
  }
}
