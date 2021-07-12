import 'package:lottery_app/models/app_user.dart';
import 'package:lottery_app/models/lottery.dart';

enum LotteryRunType { RUNNING, WIN, NO_WIN, SOLD, NO_SELL }

LotteryRunType getLotteryRunType(Lottery lottery, AppUser currentUser) {
  if (lottery.winner == null && lottery.endingDate.isAfter(DateTime.now())) {
    return LotteryRunType.RUNNING;
  } else if (lottery.winner == null) {
    return LotteryRunType.NO_SELL;
  } else if (currentUser == lottery.seller) {
    return LotteryRunType.SOLD;
  } else if (lottery.winner! == currentUser) {
    return LotteryRunType.WIN;
  } else {
    return LotteryRunType.NO_WIN;
  }
}
