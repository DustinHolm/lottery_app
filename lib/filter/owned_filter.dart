import 'package:lottery_app/filter/i_transform.dart';
import 'package:lottery_app/models/app_user.dart';
import 'package:lottery_app/models/lottery.dart';

class OwnedFilter implements ITransform {
  OwnedFilter({required this.user});

  final AppUser? user;

  @override
  Iterable<Lottery> transformLotteries(Iterable<Lottery> lotteries) {
    return lotteries.where((lottery) => lottery.seller == user);
  }
}