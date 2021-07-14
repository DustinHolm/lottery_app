import 'package:lottery_app/enums/category.dart';
import 'package:lottery_app/enums/filter.dart';
import 'package:lottery_app/filter/transform.dart';
import 'package:lottery_app/models/lottery.dart';

class CategoryFilter implements ITransform {
  final Category _category;

  CategoryFilter(Category category) : _category = category;

  @override
  Iterable<Lottery> transformLotteries(Iterable<Lottery> lotteries) {
    return lotteries.where((lottery) => lottery.category == _category);
  }

  @override
  Filter getEnum() {
    return Filter.CATEGORY_FILTER;
  }
}
